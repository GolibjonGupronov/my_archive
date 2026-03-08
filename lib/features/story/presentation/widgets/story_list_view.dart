import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/args.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/story/domain/entities/story_entity.dart';

class StoryListView extends StatelessWidget {
  final List<StoryEntity> storyList;

  const StoryListView({super.key, required this.storyList});

  @override
  Widget build(BuildContext context) {
    return storyList.isEmpty
        ? SizedBox()
        : SizedBox(
            height: 120.h,
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final item = storyList[index];

                  return Bounce(
                    onTap: () {
                      context.push(StoryPage.tag,
                          extra: StoryPageArgs(
                              storyList: storyList,
                              activeIndex: index,
                              itemCheck: (StoryEntity item) {
                                if (item.isRead != true) {
                                  item.isRead = true;
                                }
                              }));
                    },
                    child: BoxContainer(
                      width: 110.w,
                      border: BoxBorder.all(color: item.isRead ? AppColors.gray : AppColors.primary),
                      borderRadius: BorderRadius.circular(16.r),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Stack(
                          children: [
                            Positioned.fill(child: CustomImageView(pathOrUrl: item.thumbnail)),
                            Positioned.fill(
                              child: BoxContainer(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.black.withValues(alpha: 0.8),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                                child: SizedBox(),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              left: 8,
                              right: 8,
                              child: TextView(
                                item.title,
                                fontSize: 12,
                                color: AppColors.white,
                                maxLines: 5,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (c, i) => 12.width,
                itemCount: storyList.length),
          );
  }
}
