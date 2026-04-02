import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:my_archive/features/profile/presentation/widgets/profile_item.dart';

class SecurityPage extends StatelessWidget {
  final ProfileBloc bloc;

  const SecurityPage({super.key, required this.bloc});

  static const String tag = '/security_page';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar("Xavfsizlik"),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          Column(
            spacing: 20.h,
            children: [
              ProfileItem(
                title: "Parolni tahrirlash",
                prefixIconData: Icons.key_rounded,
                onTap: () {
                  context.push(OldPasswordPage.tag);
                },
              ),
              ProfileItem(
                title: "Ilova qulfi",
                prefixIconData: CupertinoIcons.lock_fill,
                onTap: () async {
                  if (await bloc.secureStorage.hasPin()) {
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
