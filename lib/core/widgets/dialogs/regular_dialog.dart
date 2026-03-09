import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_archive/core/core_exports.dart';

Future<void> showDraggableBottomSheet({
  required BuildContext context,
  required Widget Function(ScrollController controller) childBuilder,
  String title = "",
}) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => Material(
      color: context.isDarkModeEnable ? AppColors.scaffoldDarkBackground : AppColors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView(
                shrinkWrap: true,
                controller: scrollController,
                children: [
                  Center(
                      child: Container(
                          width: 50.w,
                          height: 4.h,
                          margin: EdgeInsets.only(top: 6.h),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.r), color: AppColors.gray))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      children: [
                        Expanded(child: Text(title, style: AppTheme.textTheme.displayLarge)),
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.isDarkModeEnable ? AppColors.whiteDark : AppColors.lightGray),
                            child: Icon(CupertinoIcons.xmark, size: 14.w, color: AppColors.gray),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              8.height,
              Flexible(child: childBuilder(scrollController))
            ],
          );
        },
      ),
    ),
  );
}

Future<void> showCustomBottomSheetDialog({
  required BuildContext context,
  required Widget child,
  bool isDismissible = true,
}) {
  return showCustomModalBottomSheet(
    context: context,
    isDismissible: isDismissible,
    builder: (context) => PopScope(
      canPop: isDismissible,
      child: child,
    ),
    containerWidget: (context, animation, child) => Material(
      color: context.isDarkModeEnable ? AppColors.whiteDark : AppColors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          4.height,
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              margin: EdgeInsets.all(8.w),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.r), color: AppColors.gray),
            ),
          ),
          2.height,
          Container(
            constraints: BoxConstraints(maxHeight: context.screenHeight * .8),
            child: ListView(
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              primary: false,
              shrinkWrap: true,
              children: [child],
            ),
          ),
        ],
      ),
    ),
  );
}
