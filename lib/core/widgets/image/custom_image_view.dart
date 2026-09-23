import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomImageView extends StatelessWidget {
  final String? pathOrUrl;
  final double? width;
  final double? height;
  final double? size;
  final BoxFit fit;
  final Color? color;
  final double? radius;
  final bool isBlur;

  const CustomImageView({
    required this.pathOrUrl,
    super.key,
    this.width,
    this.height,
    this.size,
    this.fit = BoxFit.cover,
    this.color,
    this.radius,
    this.isBlur = false,
  });

  @override
  Widget build(BuildContext context) {
    final double width = size ?? this.width ?? double.infinity;
    final double height = size ?? this.height ?? double.infinity;

    if (pathOrUrl == null || pathOrUrl!.isEmpty) {
      return SizedBox(width: width, height: height);
    }

    final bool isNetwork = pathOrUrl!.startsWith('http');

    Widget imageWidget;

    if (isNetwork) {
      imageWidget = CachedNetworkImage(
        imageUrl: pathOrUrl!,
        cacheManager: CustomCacheManager.instance,
        placeholder: (context, url) =>
        const Center(child: CupertinoActivityIndicator()),
        errorWidget: (context, url, error) => const SizedBox(),
        width: width,
        height: height,
        fit: fit,
        color: color,
      );
    } else {
      final file = File(pathOrUrl!);
      if (file.existsSync()) {
        imageWidget = Image.file(
          file,
          width: width,
          height: height,
          fit: fit,
          color: color,
        );
      } else {
        imageWidget = SizedBox(width: width, height: height);
      }
    }

    if (isBlur) {
      imageWidget = ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: imageWidget,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: SizedBox(
        width: width,
        height: height,
        child: imageWidget,
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