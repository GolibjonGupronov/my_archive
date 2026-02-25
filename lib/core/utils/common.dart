import 'package:flutter/material.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/utils/device_helper.dart';
import 'package:my_archive/core/utils/generated/assets.gen.dart';
import 'package:my_archive/core/widgets/text_view.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openUrl(String url, {LaunchMode mode = LaunchMode.externalApplication}) async =>
    await launchUrl(Uri.parse(url), mode: mode);

Future<bool?> callNumber(String phone) async => await launchUrl(Uri(scheme: 'tel', path: phone));

Widget aboutUsSocial() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => openUrl("https://t.me/m0b1leDevel0per"),
            child: Assets.images.telegram.image(width: 30),
          ),
          8.width,
          InkWell(
            onTap: () => openUrl("https://www.instagram.com/golibjongupronov"),
            child: Assets.images.instagram.image(width: 30),
          ),
          8.width,
          InkWell(
            onTap: () => openUrl("https://www.facebook.com/g.olibjon.g.upronov"),
            child: Assets.images.facebook.image(width: 30),
          ),
        ],
      ),
      8.height,
      const CustomTextView("Bizni ijtimoiy tarmoqlarda kuzatib boring", fontSize: 14, color: AppColors.gray),
      8.height,
      CustomTextView("Ilova versiyasi: ${DeviceHelper.packageInfo.version}",
          textAlign: TextAlign.center, fontSize: 12, color: AppColors.gray),
      16.height,
    ],
  );
}
