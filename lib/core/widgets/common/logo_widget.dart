import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/utils/generated/assets.gen.dart';

class LogoWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final double? size;
  final BoxFit? fit;

  const LogoWidget({super.key, this.height, this.width, this.size, this.fit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? height ?? 120.h,
      width: size ?? width ?? 120.w,
      child: Center(child: Assets.images.logo.image(fit: fit)),
    );
  }
}
