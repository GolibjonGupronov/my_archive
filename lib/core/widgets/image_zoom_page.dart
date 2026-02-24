import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_archive/core/app_router/app_router.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageZoomScreen extends StatefulWidget {
  final List<String> items;
  final int activeIndex;

  const ImageZoomScreen({required this.items, super.key, this.activeIndex = 0});

  @override
  State<StatefulWidget> createState() {
    return ImageZoomScreenState();
  }
}

class ImageZoomScreenState extends State<ImageZoomScreen> {
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
                height: 70,
                child: ListView.builder(
                  itemBuilder: (_, position) {
                    return InkWell(
                      onTap: () {
                        _currentImage = position;
                        pageController.jumpToPage(_currentImage);
                      },
                      child: Container(
                        height: 70,
                        width: 80,
                        margin: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            children: [
                              Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.black54,
                                child: ImageView(widget.items[position], fit: BoxFit.cover),
                              ),
                              if (_currentImage != position)
                                Container(height: double.infinity, width: double.infinity, color: Colors.black54.withAlpha(150)),
                              if (_currentImage == position)
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.primaryColor, width: 2),
                                  ),
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
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8),
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
