import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/constants/gradients.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/widgets/box_conatiner.dart';
import 'package:my_archive/core/widgets/text_view.dart';

class CustomRadioList<T> extends StatelessWidget {
  final String title;
  final T? activeSegment;
  final List<T> segments;
  final String Function(T segment) getSegmentTitle;
  final Function(T segment) onSegmentSelected;
  final bool enabled;

  const CustomRadioList(
    this.title, {
    super.key,
    required this.segments,
    required this.getSegmentTitle,
    required this.onSegmentSelected,
    this.activeSegment,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title.isNotEmpty) ...[
            CustomTextView(title),
            10.height,
          ],
          DynamicHeightGridView(
            shrinkWrap: true,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            crossAxisCount: 2,
            itemCount: segments.length,
            physics: const NeverScrollableScrollPhysics(),
            builder: (context, position) {
              final segment = segments[position];
              final isActive = segment == activeSegment;
              return GestureDetector(
                onTap: () {
                  if (enabled) {
                    onSegmentSelected(segment);
                  }
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: BoxContainer(
                    key: ValueKey<bool>(isActive),
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    borderRadius: BorderRadius.circular(16.r),
                    color: isActive ? null : AppColors.white,
                    gradient: isActive ? Gradients.primaryGradient : null,
                    withShadow: true,
                    child: Row(
                      children: [
                        Icon(
                          isActive ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked,
                          color: isActive ? AppColors.white : AppColors.gray,
                        ),
                        10.width,
                        Expanded(
                          child: CustomTextView(
                            getSegmentTitle(segment),
                            color: isActive ? AppColors.white : AppColors.black,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
