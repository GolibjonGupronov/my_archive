import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomImageView extends StatefulWidget {
  final String? pathOrUrl;
  final double? width;
  final double? height;
  final double? size;
  final BoxFit fit;
  final Color? color;
  final double? radius;
  final bool backBlur;

  const CustomImageView({
    required this.pathOrUrl,
    super.key,
    this.width,
    this.height,
    this.size,
    this.fit = BoxFit.cover,
    this.color,
    this.radius,
    this.backBlur = false,
  });

  @override
  State<CustomImageView> createState() => _CustomImageViewState();
}

class _CustomImageViewState extends State<CustomImageView> {
  ImageInfo? info;

  @override
  void initState() {
    super.initState();
    if (widget.backBlur && widget.pathOrUrl != null && widget.pathOrUrl!.isNotEmpty) {
      _loadImageInfo(widget.pathOrUrl!);
    }
  }

  Future<void> _loadImageInfo(String pathOrUrl) async {
    final ImageProvider provider;

    if (pathOrUrl.startsWith('http')) {
      provider = CachedNetworkImageProvider(pathOrUrl, cacheManager: CustomCacheManager.instance);
    } else {
      provider = FileImage(File(pathOrUrl));
    }

    final stream = provider.resolve(const ImageConfiguration());
    stream.addListener(
      ImageStreamListener((img, _) {
        if (mounted) {
          setState(() => info = img);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = widget.size ?? widget.width ?? double.infinity;
    final double height = widget.size ?? widget.height ?? double.infinity;

    if (widget.pathOrUrl == null || widget.pathOrUrl!.isEmpty) {
      return SizedBox(width: width, height: height);
    }

    final bool isNetwork = widget.pathOrUrl!.startsWith('http');
    final isPortrait = info?.image.height != null && info!.image.height > info!.image.width;

    Widget imageWidget;

    if (isNetwork) {
      imageWidget = CachedNetworkImage(
        imageUrl: widget.pathOrUrl!,
        cacheManager: CustomCacheManager.instance,
        placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()),
        errorWidget: (context, url, error) => Container(),
        width: width,
        height: height,
        fit: isPortrait ? BoxFit.contain : widget.fit,
        color: widget.color,
      );
    } else {
      final file = File(widget.pathOrUrl!);
      if (file.existsSync()) {
        imageWidget = Image.file(
          file,
          width: width,
          height: height,
          fit: isPortrait ? BoxFit.contain : widget.fit,
          color: widget.color,
        );
      } else {
        imageWidget = SizedBox(width: width, height: height);
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius ?? 0),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (widget.backBlur && isPortrait && info != null) ...[
              isNetwork
                  ? CachedNetworkImage(imageUrl: widget.pathOrUrl!, cacheManager: CustomCacheManager.instance, fit: BoxFit.cover)
                  : Image.file(File(widget.pathOrUrl!), fit: BoxFit.cover),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.black.withValues(alpha: 0.25)),
              ),
            ],
            imageWidget,
          ],
        ),
      ),
    );
  }
}

class CustomCacheManager {
  static const key = 'customCacheKey';
  static final instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );
}
