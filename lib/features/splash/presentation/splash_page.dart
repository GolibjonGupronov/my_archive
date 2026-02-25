import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/core/extensions/common.dart';
import 'package:my_archive/core/di/injection_container.dart';
import 'package:my_archive/core/widgets/custom_scaffold.dart';
import 'package:my_archive/features/auth/presentation/phone/phone_page.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_event.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_state.dart';
import 'package:overlay_support/overlay_support.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const String tag = '/splash';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SplashBloc(userInfoUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<SplashBloc>(context);

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.splashStatus.isFailure) {
          toast(state.errorMessage);
        } else if (state.splashStatus.isSuccess) {
          if (state.nextPage == NextPage.auth) {
            context.go(PhonePage.tag);
          }
        }
      },
      child: CustomScaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
