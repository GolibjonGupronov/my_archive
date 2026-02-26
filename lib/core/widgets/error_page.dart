import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/widgets/button.dart';
import 'package:my_archive/core/widgets/text_view.dart';

class ErrorPage extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const ErrorPage({super.key, required this.errorDetails});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning_rounded, color: Colors.red),
            16.height,
            CustomTextView("Something went wrong!", fontSize: 24.sp, color: AppColors.black),
            CustomButton("Go to Main Page", () => context.go(SplashPage.tag)),
          ],
        ),
      ),
    );
  }
}