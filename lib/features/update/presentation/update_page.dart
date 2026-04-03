import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/entities/app_config_entity.dart';

class UpdatePage extends StatelessWidget {
  final AppConfigEntity appConfigEntity;

  const UpdatePage({super.key, required this.appConfigEntity});

  static const String tag = '/update_page';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isExitDialog: true,
      appBar: CustomAppBar("Yangi versiya"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          40.height,
          Assets.images.update.image(height: 200.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: ListView(
                children: [
                  60.height,
                  TextView(tr('update_app'), textAlign: TextAlign.center, fontSize: 24.sp),
                  30.height,
                  TextView(tr('update_app_message', args: [Platform.isIOS ? "App Store" : "Google Play"]),
                      textAlign: TextAlign.center),
                  80.height,
                  CustomButton(tr('update'), () {
                    openUrl(Platform.isIOS ? appConfigEntity.appStoreLink : appConfigEntity.googlePlayLink);
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
