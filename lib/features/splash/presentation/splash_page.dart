import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/presentation/widgets/language_widget.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_event.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const String tag = '/splash_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          SplashBloc(userInfoUseCase: sl(), prefManager: sl(), appConfigUseCase: sl(), secureStorage: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    debugPrint("GGQ => SplashPage");
    final bloc = BlocProvider.of<SplashBloc>(context);

    return BlocListener<SplashBloc, SplashState>(
      listenWhen: (p, c) => p.splashStatus != c.splashStatus,
      listener: (context, state) async {
        if (state.splashStatus.isFailure) {
          showErrorDialog(context, title: state.errorMessage);
        } else if (state.splashStatus.isSuccess) {
          if (state.isFirstLaunch == true) {
            if (!context.mounted) return;
            await showCustomBottomSheetDialog(context: context, child: LanguageWidget())
                .then((value) async => await sl.get<PrefManager>().setNotFirstLaunch(false));
          }
          if (state.nextPage == NextPage.main) {
            if (await bloc.secureStorage.hasPin()) {
              router.push(AppLockPage.tag).then((value) {
                if (value != null) {
                  router.go(MainPage.tag);
                }
              });
              return;
            }
          }
          router.go(state.nextPage.page);
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
                child: LogoWidget(),
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
