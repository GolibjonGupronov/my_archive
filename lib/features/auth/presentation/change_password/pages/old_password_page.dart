import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_archive/features/auth/presentation/change_password/blocs/old/old_password_bloc.dart';
import 'package:my_archive/features/auth/presentation/change_password/blocs/old/old_password_event.dart';
import 'package:my_archive/features/auth/presentation/change_password/blocs/old/old_password_state.dart';

class OldPasswordPage extends StatelessWidget {
  const OldPasswordPage({super.key});

  static const String tag = '/old_password_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OldPasswordBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<OldPasswordBloc>(context);

    return Container();
  }
}

