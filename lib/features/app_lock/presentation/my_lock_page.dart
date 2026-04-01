import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/services/local_auth_service.dart';
import 'package:my_archive/features/app_lock/presentation/blocs/lock/my_lock_bloc.dart';
import 'package:my_archive/features/app_lock/presentation/blocs/lock/my_lock_event.dart';
import 'package:my_archive/features/app_lock/presentation/blocs/lock/my_lock_state.dart';
import 'package:my_archive/features/app_lock/presentation/widgets/auto_lock_widget.dart';
import 'package:my_archive/features/profile/presentation/widgets/profile_item.dart';

class MyLockPage extends StatelessWidget {
  const MyLockPage({super.key});

  static const String tag = '/my_lock_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MyLockBloc(secureStorage: sl(), prefManager: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<MyLockBloc>(context);

    return BlocListener<MyLockBloc, MyLockState>(
      listenWhen: (p, c) => p.pinStatus != c.pinStatus,
      listener: (context, state) {
        if (state.pinStatus.isSuccess) {
          context.pop();
        }
      },
      child: CustomScaffold(
        appBar: CustomAppBar("Ilova qulfi"),
        body: ListView(
          padding: EdgeInsets.all(20.w),
          children: [
            ProfileItem(
              title: "Yangi PIN o'rnatish",
              prefixIconData: CupertinoIcons.lock_rotation_open,
              onTap: () {
                context.push(NewPinPage.tag).then((value) {
                  if (value != null) router.pop();
                });
              },
            ),
            20.height,
            BlocSelector<MyLockBloc, MyLockState, bool>(
              selector: (state) => state.hasPin,
              builder: (context, state) {
                if (!state) {
                  return const SizedBox();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (LocalAuthService.canUseBiometric) ...[
                      BlocSelector<MyLockBloc, MyLockState, bool>(
                        selector: (state) => state.isBiometricEnabled,
                        builder: (context, state) {
                          debugPrint("GGQ => Biometric state: $state");
                          return ProfileItem(
                            title: "Biometrik qulf",
                            prefixIconData: Icons.fingerprint_rounded,
                            suffixWidget: CupertinoSwitch(
                              value: state,
                              onChanged: (value) async {
                                bloc.add(ToggleBiometricEvent(value: value));
                              },
                            ),
                          );
                        },
                      ),
                      20.height,
                    ],
                    BlocSelector<MyLockBloc, MyLockState, AutoLockTimeType>(
                      selector: (state) => state.autoLockTime,
                      builder: (context, state) {
                        return ProfileItem(
                          title: "Avtomatik qulflash",
                          prefixIconData: CupertinoIcons.time,
                          onTap: () {
                            showCustomDialog(context,
                                child: AutoLockWidget(
                                    onTimeSelected: (AutoLockTimeType type) {
                                      bloc.add(AutoLockTimeEvent(timeType: type));
                                    },
                                    initialTime: state));
                          },
                          suffixWidget: Row(
                            children: [
                              TextView(state.title,fontWeight: FontWeight.w400, fontSize: 14.sp),
                              4.width,
                              Icon(CupertinoIcons.chevron_forward)
                            ],
                          ),
                        );
                      },
                    ),
                    20.height,
                    ProfileItem(
                      title: "Ilova qulfini o'chirish",
                      prefixIconData: CupertinoIcons.trash,
                      onTap: () {
                        showRejectDialog(context, "Ilova qulfini o'chirish",
                            subTitle: "Haqiqatan ham ilova qulfini o'chirmoqchimisiz?", onConfirm: () {
                          bloc.add(RemovePinEvent());
                        });
                      },
                    ),
                    20.height,
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
