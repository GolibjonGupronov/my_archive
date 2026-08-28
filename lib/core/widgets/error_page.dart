import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/core/exports/route_exports.dart';

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
            TextView("Something went wrong!", fontSize: 24.sp, color: AppColors.black),
            CustomButton("Go to Main Page", () => context.go(SplashPage.tag)),
          ],
        ),
      ),
    );
  }
}
