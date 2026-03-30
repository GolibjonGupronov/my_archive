import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/app_lock/presentation/blocs/new_pin/new_pin_bloc.dart';
import 'package:my_archive/features/app_lock/presentation/blocs/new_pin/new_pin_event.dart';
import 'package:my_archive/features/app_lock/presentation/blocs/new_pin/new_pin_state.dart';

class NewPinPage extends StatelessWidget {
  NewPinPage({super.key});

  static const String tag = '/new_pin_page';

  final TextEditingController pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewPinBloc(secureStorage: sl(), prefManager: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<NewPinBloc>(context);

    return BlocListener<NewPinBloc, NewPinState>(
      listenWhen: (previous, current) => previous.appLockStatus != current.appLockStatus,
      listener: (context, state) {
        if (state.appLockStatus.isSuccess) {
          showSuccessToast(context, "Ilova qulfi o'rnatildi");
          router.pop(true);
        }
      },
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
                    TextView("Yangi PIN kod kiriting"),
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
                BlocBuilder<NewPinBloc, NewPinState>(
                  builder: (context, state) {
                    return CustomButton("Saqlash", () {
                      bloc.add(SavePinEvent(pinCode: pinCodeController.text));
                    }, active: state.isActive);
                  },
                ),
              ],
            ),
          )),
    );
  }
}
