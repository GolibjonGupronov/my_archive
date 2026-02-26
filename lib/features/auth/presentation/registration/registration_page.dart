import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/features/auth/presentation/registration/bloc/registration_bloc.dart';
import 'package:my_archive/features/auth/presentation/registration/bloc/registration_event.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  static const String tag = '/registration_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegistrationBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<RegistrationBloc>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Registration"),
      ),
    );
  }
}
