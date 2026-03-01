import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/core_exports.dart';

import 'package:my_archive/features/home/presentation/bloc/home_bloc.dart';
import 'package:my_archive/features/home/presentation/bloc/home_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);

    return CustomScaffold(
      appBar: CustomAppBar(tr('home')),
      body: CustomButton("Chiqish", (){
        logoutApp();
      }),
    );
  }
}

