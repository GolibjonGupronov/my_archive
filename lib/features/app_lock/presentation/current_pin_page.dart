import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/app_lock/presentation/blocs/current_pin/current_pin_bloc.dart';
import 'package:my_archive/features/app_lock/presentation/blocs/current_pin/current_pin_event.dart';
import 'package:my_archive/features/app_lock/presentation/blocs/current_pin/current_pin_state.dart';

class CurrentPinPage extends StatelessWidget {
  CurrentPinPage({super.key});

  static const String tag = '/current_pin_page';

  final TextEditingController pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CurrentPinBloc(secureStorage: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<CurrentPinBloc>(context);

    return BlocListener<CurrentPinBloc, CurrentPinState>(
      listenWhen: (previous, current) => previous.checkCurrentPinStatus != current.checkCurrentPinStatus,
      listener: (context, state) {
        if (state.checkCurrentPinStatus.isSuccess) {
          context.pushReplacement(MyLockPage.tag);
        } else if (state.checkCurrentPinStatus.isFailure) {
          showErrorToast(context, state.errorMessage);
        }
      },
      child: CustomScaffold(
          appBar: CustomAppBar("PIN"),
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    LogoWidget(),
                    30.height,
                    TextView("Hozirgi PIN kod kiriting"),
                    20.height,
                    CustomPinPut(
                        controller: pinCodeController,
                        context: context,
                        length: Constants.pinCodeLength,
                        obscureText: true,
                        onChanged: (value) {
                          bloc.add(UpdateFieldEvent(pinCode: value));
                        }),
                  ],
                )),
                BlocBuilder<CurrentPinBloc, CurrentPinState>(
                  builder: (context, state) {
                    return CustomButton("Saqlash", () {
                      bloc.add(CheckCurrentPinEvent(pinCode: pinCodeController.text));
                    }, active: state.isActive);
                  },
                ),
              ],
            ),
          )),
    );
  }
}
