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

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileBloc(prefManager: sl(), changeImageUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
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
        appBar: CustomAppBar(tr('profile')),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 32.h),
                children: [
                  ProfileImage(bloc: bloc),
                  60.height,
                  ProfileItem(
                    onTap: () async {
                      var value = await context.push(EditProfilePage.tag);
                      if (value != null) {
                        bloc.add(InitEvent());
                      }
                    },
                    title: "Mening ma'lumotlarim",
                    rightWidget: Icon(CupertinoIcons.profile_circled),
                  ),
                  20.height,
                  ProfileItem(
                    onTap: () {
                      context.push(OldPasswordPage.tag);
                    },
                    title: "Parol almashtirish",
                    rightWidget: Icon(CupertinoIcons.lock_shield),
                  ),
                  20.height,
                  ProfileItem(
                    title: tr('settings'),
                    rightWidget: Icon(Icons.settings),
                    onTap: () {
                      context.push(SettingsPage.tag);
                    },
                  ),
                  20.height,
                  ProfileItem(
                    title: "Qurilma sessiyasi",
                    onTap: () {
                      context.push(DeviceSessionPage.tag);
                    },
                    rightWidget: Icon(Icons.phone_android_rounded),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Bounce(
                onTap: () {
                  showRejectDialog(context, tr('logout'), subTitle: tr('confirm_logout'), onConfirm: () {
                    logoutApp();
                  });
                },
                child: BoxContainer(
                  color: AppColors.red.withValues(alpha: .8),
                  withShadow: true,
                  borderRadius: BorderRadius.circular(16.r),
                  child: SizedBox(
                      height: 54.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView(tr('logout'), maxLines: 1, color: AppColors.white),
                          12.width,
                          Icon(Icons.logout, color: AppColors.white),
                        ],
                      )),
                ),
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
