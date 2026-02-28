import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/constants/constants.dart';
import 'package:my_archive/core/mixins/safe_caller.dart';
import 'package:my_archive/core/widgets/app_bar.dart';
import 'package:my_archive/core/widgets/button.dart';
import 'package:my_archive/core/widgets/scaffold.dart';
import 'package:my_archive/core/widgets/text_view.dart';

import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';
import 'bloc/main_state.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const String tag = '/main_page';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MainBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<MainBloc>(context);

    return CustomScaffold(
      isExitDialog: true,
      appBar: CustomAppBar(Constants.appName),
      body: CustomButton("Chiqish", (){
        logoutApp();
      }),
    );
  }
}

