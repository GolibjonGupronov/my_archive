import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/app_router.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/extensions/common.dart';
import 'package:my_archive/core/widgets/bounce.dart';
import 'package:my_archive/core/widgets/box_conatiner.dart';
import 'package:my_archive/core/widgets/image/custom_image_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageZoomPage extends StatefulWidget {
  final List<String> items;
  final int activeIndex;

  const ImageZoomPage({required this.items, super.key, this.activeIndex = 0});

  @override
  State<StatefulWidget> createState() => ImageZoomPageState();
}

class ImageZoomPageState extends State<ImageZoomPage> {
  var _currentImage = 0;
  PageController pageController = PageController();
  var imageLoading = false;

  @override
  void initState() {
    _currentImage = widget.activeIndex;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageController.jumpToPage(_currentImage);
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            pageController: pageController,
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(widget.items[index]),
                maxScale: PhotoViewComputedScale.covered,
                minScale: PhotoViewComputedScale.contained,
                initialScale: PhotoViewComputedScale.contained * 0.9,
                heroAttributes: PhotoViewHeroAttributes(tag: index),
              );
            },
            itemCount: widget.items.length,
            onPageChanged: (position) {
              setState(() {
                _currentImage = position;
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: SizedBox(
                height: 70.h,
                child: ListView.builder(
                  itemBuilder: (_, position) {
                    return Bounce(
                      onTap: () {
                        _currentImage = position;
                        pageController.jumpToPage(_currentImage);
                      },
                      child: Container(
                        height: 70.h,
                        width: 80.w,
                        margin: EdgeInsets.all(8.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Stack(
                            children: [
                              Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.black54,
                                child: CustomImageView(pathOrUrl: widget.items[position], fit: BoxFit.cover),
                              ),
                              if (_currentImage != position)
                                Container(height: double.infinity, width: double.infinity, color: Colors.black54.withAlpha(150)),
                              if (_currentImage == position)
                                BoxContainer(
                                  height: double.infinity,
                                  width: double.infinity,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: AppColors.primary, width: 2.w),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: widget.items.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: context.safeTop(8)),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  router.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded, color: AppColors.gray),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
