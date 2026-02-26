import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_archive/core/animations/scale_animation.dart';
import 'package:my_archive/core/di/injection_container.dart';
import 'package:my_archive/core/extensions/common.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/utils/generated/assets.gen.dart';
import 'package:my_archive/core/widgets/dialogs/custom_dialog.dart';
import 'package:my_archive/core/widgets/scaffold.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_event.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const String tag = '/splash';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          SplashBloc(userInfoUseCase: sl(), prefManager: sl(), appConfigUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<SplashBloc>(context);

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.splashStatus.isFailure) {
          showErrorDialog(context, title: state.errorMessage);
        } else if (state.splashStatus.isSuccess) {
          context.go(state.nextPage.page);
        }
      },
      child: CustomScaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleAnimation(
                curve: Curves.easeOut,
                duration: Duration(seconds: 1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: Container(
                    color: Colors.red,
                    child: Assets.images.logo.image(width: context.screenWidth / 2, height: context.screenWidth / 2),
                  ),
                ),
              ),
              50.height,
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
