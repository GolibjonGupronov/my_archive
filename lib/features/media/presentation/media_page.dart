import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/di/injection_container.dart';

import 'package:my_archive/features/media/presentation/bloc/media_bloc.dart';
import 'package:my_archive/features/media/presentation/bloc/media_event.dart';
import 'package:my_archive/features/media/presentation/bloc/media_state.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MediaBloc(mediaUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<MediaBloc>(context);

    return Container();
  }
}

