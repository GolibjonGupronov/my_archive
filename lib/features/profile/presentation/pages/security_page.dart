import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/core/exports/route_exports.dart';
import 'package:my_archive/features/profile/presentation/widgets/profile_item.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  static const String tag = '/security_page';

  @override
  Widget build(BuildContext context) {
    logger("GGQ => SecurityPage");
    return CustomScaffold(
      appBar: CustomAppBar("Xavfsizlik"),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          Column(
            spacing: 20.h,
            children: [
              ComingSoonWidget(
                child: ProfileItem(
                  title: "Parolni tahrirlash",
                  prefixIconData: Icons.key_rounded,
                  onTap: () {
                    context.push(OldPasswordPage.tag);
                  },
                ),
              ),
              ProfileItem(
                title: "Ilova qulfi",
                prefixIconData: CupertinoIcons.lock_fill,
                onTap: () async {
                  final hasPin = await sl.get<SecureStorage>().hasPin;
                  if (hasPin) {
                    router.push(CurrentPinPage.tag);
                  } else {
                    router.push(NewPinPage.tag);
                  }
                },
              ),
              ProfileItem(
                title: "Qurilma sessiyasi",
                prefixIconData: Icons.phone_android_rounded,
                onTap: () {
                  context.push(DeviceSessionPage.tag);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
