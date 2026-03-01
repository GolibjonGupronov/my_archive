import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_event.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);

    return CustomScaffold(
      appBar: CustomAppBar(tr('profile')),
    );
  }
}
