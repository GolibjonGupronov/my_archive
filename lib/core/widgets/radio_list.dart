import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';

class CustomRadioList<T> extends StatelessWidget {
  final String title;
  final T? activeSegment;
  final List<T> segments;
  final String Function(T segment) getSegmentTitle;
  final Function(T segment) onSegmentSelected;
  final bool enabled;
  final Gradient? activeGradient;

  const CustomRadioList(
    this.title, {
    super.key,
    required this.segments,
    required this.getSegmentTitle,
    required this.onSegmentSelected,
    this.activeSegment,
    this.enabled = true,
    this.activeGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title.isNotEmpty) ...[
            TextView(title),
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
              return Bounce(
                onTap: () {
                  if (enabled) {
                    onSegmentSelected(segment);
                  }
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: BoxContainer(
                    key: ValueKey<bool>(isActive),
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    borderRadius: BorderRadius.circular(60.r),
                    gradient: isActive ? activeGradient ?? Gradients.primaryGradient : null,
                    withShadow: false,
                    child: Row(
                      children: [
                        Icon(
                          isActive ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked,
                          color: isActive
                              ? AppColors.white
                              : context.isDarkModeEnable
                                  ? AppColors.white
                                  : AppColors.black,
                        ),
                        10.width,
                        Expanded(
                          child: TextView(
                            getSegmentTitle(segment),
                            color: isActive
                                ? AppColors.white
                                : context.isDarkModeEnable
                                    ? AppColors.white
                                    : AppColors.black,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
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
