import 'package:flutter/material.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/utils/common.dart';
import 'package:my_archive/core/utils/device_helper.dart';
import 'package:my_archive/core/utils/generated/assets.gen.dart';
import 'package:my_archive/core/widgets/text_view.dart';

class AboutUsSocial extends StatelessWidget {
  const AboutUsSocial({super.key});

  void _open(String url) => openUrl(url);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _open("https://t.me/m0b1leDevel0per"),
              child: Assets.images.telegram.image(width: 30),
            ),
            8.width,
            InkWell(
              onTap: () => _open("https://www.instagram.com/golibjongupronov"),
              child: Assets.images.instagram.image(width: 30),
            ),
            8.width,
            InkWell(
              onTap: () => _open("https://www.facebook.com/g.olibjon.g.upronov"),
              child: Assets.images.facebook.image(width: 30),
            ),
          ],
        ),
        8.height,
        CustomTextView(
          "Bizni ijtimoiy tarmoqlarda kuzatib boring",
          fontSize: 14,
          color: AppColors.gray,
        ),
        8.height,
        CustomTextView(
          "Ilova versiyasi: ${DeviceHelper.packageInfo.version}",
          textAlign: TextAlign.center,
          fontSize: 12,
          color: AppColors.gray,
        ),
        16.height,
      ],
    );
  }
}
