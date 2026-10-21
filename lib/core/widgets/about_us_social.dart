import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/di/injection_container.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/core/local_storage/pref_manager.dart';
import 'package:my_archive/core/services/device_service.dart';
import 'package:my_archive/features/auth/domain/entities/app_config_entity.dart';

class AboutUsSocial extends StatelessWidget {
  const AboutUsSocial({super.key});

  void _open(BuildContext context, String? url) {
    if ((url ?? "").isEmpty) {
      showErrorDialog(context, title: tr('no_data'));
    }
    openUrl(url!);
  }

  @override
  Widget build(BuildContext context) {
    AppConfigEntity? appConfig = sl.get<PrefManager>().getAppConfig;
    return Column(
      children: [
        Row(
          spacing: 14.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Bounce(
              onTap: () => _open(context, appConfig?.telegram),
              child: Assets.images.telegram.image(width: 30),
            ),
            Bounce(
              onTap: () => _open(context, appConfig?.instagram),
              child: Assets.images.instagram.image(width: 30),
            ),
            Bounce(
              onTap: () => _open(context, appConfig?.facebook),
              child: Assets.images.facebook.image(width: 30),
            ),
          ],
        ),
        8.height,
        TextView(
          tr('follow_us'),
          fontSize: 14,
          textAlign: TextAlign.center,
          color: AppColors.gray,
        ),
        2.height,
        TextView(
          "${tr('app_version')}: ${DeviceService.packageInfo.version}",
          textAlign: TextAlign.center,
          fontSize: 12,
          color: AppColors.gray,
        ),
      ],
    );
  }
}
