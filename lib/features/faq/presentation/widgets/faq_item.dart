import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/faq/domain/entities/faq_entity.dart';

class FaqItem extends StatefulWidget {
  final FaqEntity item;

  const FaqItem({super.key, required this.item});

  @override
  State<FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> with TickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: BoxContainer(
        borderRadius: BorderRadius.circular(16.r),
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: TextView(widget.item.question)),
                AnimatedRotation(
                  turns: _expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.gray,
                  ),
                ),
              ],
            ),
            ClipRect(
              child: AnimatedAlign(
                alignment: Alignment.topCenter,
                heightFactor: _expanded ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: TextView(
                    widget.item.answer,
                    color: AppColors.gray,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
