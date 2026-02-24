import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/app_router/app_router.dart';
import 'package:my_archive/core/extensions/common.dart';
import 'package:my_archive/core/di/injection_container.dart';
import 'package:my_archive/features/auth/domain/use_cases/send_phone_use_case.dart';
import 'package:my_archive/features/auth/presentation/phone/bloc/phone_bloc.dart';
import 'package:my_archive/features/auth/presentation/phone/bloc/phone_event.dart';
import 'package:my_archive/features/auth/presentation/phone/bloc/phone_state.dart';
import 'package:overlay_support/overlay_support.dart';

class PhonePage extends StatelessWidget {
  const PhonePage({super.key});

  static const String tag = '/phone_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PhoneBloc(sendPhoneUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<PhoneBloc>(context);

    return BlocListener<PhoneBloc, PhoneState>(
      listener: (context, state) {
        if (state.phoneStatus.isFailure) {
          toast(state.errorMessage);
        } else if (state.phoneStatus.isSuccess) {
          router.push(state.authNextPage.page);
          toast("success ${state.authNextPage}");
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                bloc.add(SendPhoneEvent(phone: "+998999940941"));
              },
              child: Text("ok")),
        ),
      ),
    );
  }
}
