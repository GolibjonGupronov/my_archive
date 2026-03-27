import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/app_lock/presentation/bloc/app_lock_bloc.dart';
import 'package:my_archive/features/app_lock/presentation/bloc/app_lock_event.dart';
import 'package:my_archive/features/app_lock/presentation/bloc/app_lock_state.dart';

class AppLockPage extends StatelessWidget {
  AppLockPage({super.key});

  static const String tag = '/app_lock_page';

  final TextEditingController pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppLockBloc(secureStorage: sl(), prefManager: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<AppLockBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AppLockBloc, AppLockState>(
          listenWhen: (previous, current) => previous.appLockStatus != current.appLockStatus,
          listener: (context, state) {
            if (state.appLockStatus.isSuccess) {
              showSuccessToast(context, "Ilova qulfi o'rnatildi");
              router.pop(true);
            }
          },
        ),
        BlocListener<AppLockBloc, AppLockState>(
          listenWhen: (previous, current) => previous.checkOldPinStatus != current.checkOldPinStatus,
          listener: (context, state) {
            if (state.checkOldPinStatus.isFailure) {
              showErrorToast(context, state.errorMessage);
            }
          },
        ),
      ],
      child: CustomScaffold(
          appBar: CustomAppBar("Ilova qulfi"),
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    LogoWidget(),
                    30.height,
                    BlocSelector<AppLockBloc, AppLockState, bool>(
                      selector: (state) => state.isNewPinCode,
                      builder: (context, state) {
                        return TextView(state ? "Yangi pin kod kiriting" : "Hozirgi pin kod kiriting");
                      },
                    ),
                    20.height,
                    CustomPinPut(
                        controller: pinCodeController,
                        context: context,
                        length: 4,
                        obscureText: true,
                        onChanged: (value) {
                          bloc.add(UpdateFieldEvent(pinCode: value));
                        }),
                  ],
                )),
                BlocBuilder<AppLockBloc, AppLockState>(
                  builder: (context, state) {
                    return CustomButton("Saqlash", () {
                      if (state.isNewPinCode) {
                        bloc.add(SavePinEvent(pinCode: pinCodeController.text));
                      } else {
                        bloc.add(CheckOldPinEvent(pinCode: pinCodeController.text));
                      }
                      pinCodeController.clear();
                    }, active: state.isActive);
                  },
                ),
              ],
            ),
          )),
    );
  }
}
