import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/di/injection_container.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';
import 'package:my_archive/features/auth/presentation/sms/bloc/sms_bloc.dart';
import 'package:my_archive/features/auth/presentation/sms/bloc/sms_event.dart';

class SmsPage extends StatelessWidget {
  const SmsPage({super.key});

  static const String tag = '/sms_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SmsBloc(checkSmsUseCase: sl(), userInfoUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<SmsBloc>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("sms"),
            ElevatedButton(
                onPressed: () {
                  bloc.add(CheckSmsEvent(params: CheckSmsParams(phone: '+998999940941', sms: '1234')));
                },
                child: Text("ok"))
          ],
        ),
      ),
    );
  }
}
