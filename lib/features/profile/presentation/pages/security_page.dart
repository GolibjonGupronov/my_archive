import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/presentation/widgets/profile_item.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  static const String tag = '/security_page';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar("Xavfsizlik"),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          ProfileItem(
            title: "Parolni tahrirlash",
            prefixIconData: Icons.key_rounded,
            onTap: () {
              context.push(OldPasswordPage.tag);
            },
          ),
          20.height,
          ProfileItem(
            title: "Ilova qulfi",
            prefixIconData: CupertinoIcons.lock_fill,
            onTap: () {},
          ),
          20.height,
          ProfileItem(
            title: "Biometrik qulf",
            prefixIconData: Icons.fingerprint_rounded,
            suffixWidget: CupertinoSwitch(
              value: false,
              onChanged: (value) {},
            ),
          ),
          20.height,
          ProfileItem(
            title: "Qurilma sessiyasi",
            prefixIconData: Icons.phone_android_rounded,
            onTap: () {
              context.push(DeviceSessionPage.tag);
            },
          ),
        ],
      ),
    );
  }
}
