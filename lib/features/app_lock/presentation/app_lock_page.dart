import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/widgets/pin_put_with_keyboard.dart';
import 'package:my_archive/features/app_lock/presentation/blocs/app_lock/app_lock_bloc.dart';
import 'package:my_archive/features/app_lock/presentation/blocs/app_lock/app_lock_event.dart';
import 'package:my_archive/features/app_lock/presentation/blocs/app_lock/app_lock_state.dart';

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

    return BlocListener<AppLockBloc, AppLockState>(
      listenWhen: (previous, current) => previous.lockStatus != current.lockStatus,
      listener: (context, state) {
        if (state.lockStatus.isSuccess) {
          context.go(MainPage.tag);
        } else if (state.lockStatus.isFailure) {
          showErrorToast(context, state.errorMessage);
        }
      },
      child: CustomScaffold(
          body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            90.height,
            Expanded(
              child: ListView(
                children: [
                  LogoWidget(),
                  30.height,
                  TextView("PIN kod kiriting", textAlign: TextAlign.center),
                  20.height,
                  PinPutWithKeyboard(
                    controller: pinCodeController,
                    maxLength: Constants.pinCodeLength,
                    onChanged: (value) {
                      bloc.add(UpdateFieldEvent(pinCode: value));
                    },
                    onFingerprint: () {
                      bloc.add(InitEvent());
                    },
                    showFingerPrint: true,
                  ),
                ],
              ),
            ),
            BlocBuilder<AppLockBloc, AppLockState>(
              builder: (context, state) {
                return CustomButton("Saqlash", () {
                  bloc.add(CheckPinEvent(pinCode: pinCodeController.text));
                }, active: state.isActive);
              },
            ),
          ],
        ),
      )),
    );
  }
}
