import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_event.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_state.dart';
import 'package:my_archive/features/profile/presentation/widgets/profile_image.dart';
import 'package:my_archive/features/profile/presentation/widgets/profile_item.dart';
import 'package:share_plus/share_plus.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileBloc(
          prefManager: sl(),
          changeImageUseCase: sl(),
          enableNotificationUseCase: sl(),
          userInfoUseCase: sl(),
          secureStorage: sl())
        ..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    debugPrint("GGQ => ProfilePage");
    final bloc = BlocProvider.of<ProfileBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(
          listenWhen: (previous, current) => previous.changeImageStatus != current.changeImageStatus,
          listener: (context, state) {
            if (state.changeImageStatus.isFailure) {
              showErrorDialog(context, title: state.errorMessage);
            }
          },
        ),
      ],
      child: CustomScaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          tr('profile'),
          showBackButton: false,
          actions: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Bounce(
                  onTap: () {
                    showRejectDialog(context, tr('logout'), subTitle: tr('confirm_logout'), onConfirm: () {
                      logoutApp();
                    });
                  },
                  child: BoxContainer(
                    padding: EdgeInsets.all(8.w),
                    color: AppColors.red,
                    shape: BoxShape.circle,
                    child: Icon(Icons.logout_rounded, color: AppColors.white, size: 20.w),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 32.h),
                children: [
                  ProfileImage(bloc: bloc),
                  50.height,
                  Column(
                    spacing: 15.h,
                    children: [
                      ProfileItem(
                        title: "Mening ma'lumotlarim",
                        prefixIconData: CupertinoIcons.profile_circled,
                        onTap: () async {
                          var value = await context.push(EditProfilePage.tag);
                          if (value != null) {
                            bloc.add(InitEvent());
                          }
                        },
                      ),
                      ProfileItem(
                        title: "Xavfsizlik",
                        prefixIconData: CupertinoIcons.lock_shield,
                        onTap: () {
                          context.push(SecurityPage.tag, extra: bloc);
                        },
                      ),
                      ProfileItem(
                        title: tr('settings'),
                        prefixIconData: Icons.settings,
                        onTap: () {
                          context.push(SettingsPage.tag, extra: bloc);
                        },
                      ),
                      ProfileItem(
                        title: "Yordam",
                        prefixIconData: Icons.help,
                        onTap: () {
                          context.push(HelpPage.tag);
                        },
                      ),
                      ProfileItem(
                        title: "Ulashish",
                        prefixIconData: Icons.share_rounded,
                        onTap: () {
                          shareApp();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            10.height,
            AboutUsSocial(),
            context.safeBottomSpace(80),
          ],
        ),
      ),
    );
  }
}

void shareApp() async {
  final androidLink = 'https://play.google.com/store/apps/details?id=uz.evo_med_group.evo_med';
  final iosLink = 'https://apps.apple.com/us/app/evomed/id6758425374';

  final link = Platform.isIOS ? iosLink : androidLink;

  await SharePlus.instance.share(
    ShareParams(
      text: '🚀 Ilovani yuklab oling:\n$link',
      subject: 'Bizning ilova',
    ),
  );
}
