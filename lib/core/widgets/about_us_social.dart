import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';

class AboutUsSocial extends StatelessWidget {
  const AboutUsSocial({super.key});

  void _open(String url) => openUrl(url);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 14.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Bounce(
              onTap: () => _open("https://t.me/m0b1leDevel0per"),
              child: Assets.images.telegram.image(width: 30),
            ),
            Bounce(
              onTap: () => _open("https://www.instagram.com/golibjongupronov"),
              child: Assets.images.instagram.image(width: 30),
            ),
            Bounce(
              onTap: () => _open("https://www.facebook.com/g.olibjon.g.upronov"),
              child: Assets.images.facebook.image(width: 30),
            ),
          ],
        ),
        8.height,
        TextView(
          "Bizni ijtimoiy tarmoqlarda kuzatib boring",
          fontSize: 14,
          textAlign: TextAlign.center,
          color: AppColors.gray,
        ),
        2.height,
        TextView(
          "Ilova versiyasi: ${DeviceHelper.packageInfo.version}",
          textAlign: TextAlign.center,
          fontSize: 12,
          color: AppColors.gray,
        ),
      ],
    );
  }
}
