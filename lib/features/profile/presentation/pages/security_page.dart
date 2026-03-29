import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/services/local_auth_service.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_event.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_state.dart';
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
            onTap: () {
              context.push(AppLockPage.tag).then((value) => bloc.add(CheckBiometricEvent()));
            },
          ),
          20.height,
          FutureBuilder(
              future: LocalAuthService.canUseBiometric(),
              builder: (context, snapshot) {
                if (!(snapshot.data ?? false)) return const SizedBox();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocSelector<ProfileBloc, ProfileState, bool>(
                      bloc: bloc,
                      selector: (state) => state.isBiometricEnabled,
                      builder: (context, state) {
                        return ProfileItem(
                          title: "Biometrik qulf",
                          prefixIconData: Icons.fingerprint_rounded,
                          suffixWidget: CupertinoSwitch(
                            value: state,
                            onChanged: (value) async {
                              if (await bloc.secureStorage.hasPin()) {
                                bloc.add(ToggleBiometricEvent(value: value));
                              } else {
                                router.push(AppLockPage.tag).then((value) => bloc.add(CheckBiometricEvent()));
                              }
                            },
                          ),
                        );
                      },
                    ),
                    20.height,
                  ],
                );
              }),
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
