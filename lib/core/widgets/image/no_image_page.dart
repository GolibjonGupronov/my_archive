import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_archive/core/exports/ui_exports.dart';

class NoImagePage extends StatelessWidget {
  const NoImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          Center(child: TextView(tr('no_image'))),
          Positioned(
            top: 20.h,
            left: 16.w,
            child: SafeArea(
              child: Bounce(
                onTap: () {
                  context.pop();
                },
                child: BoxContainer(
                  shape: BoxShape.circle,
                  padding: EdgeInsets.all(10.w),
                  child: Icon(CupertinoIcons.chevron_back, size: 18.w),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
