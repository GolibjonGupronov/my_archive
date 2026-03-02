import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/use_cases/app_config_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/user_info_use_case.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_event.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final UserInfoUseCase userInfoUseCase;
  final AppConfigUseCase appConfigUseCase;
  final PrefManager prefManager;

  SplashBloc({required this.userInfoUseCase, required this.prefManager, required this.appConfigUseCase}) : super(SplashState()) {
    on<InitEvent>((event, emit) async {
      add(AppConfigEvent());
    });
    on<AppConfigEvent>((event, emit) async {
      await _appConfig(emit);
    });
    on<UserDataEvent>((event, emit) async {
      await _getUserInfo(emit);
    });
  }

  Future<void> _appConfig(Emitter<SplashState> emit) async {
    emit(state.copyWith(splashStatus: StateStatus.inProgress));
    final result = await appConfigUseCase.callUseCase(NoParams());
    result.fold((fail) {
      emit(state.copyWith(splashStatus: StateStatus.failure, errorMessage: fail.message));
    }, (data) {
      final int? buildCode = int.tryParse(DeviceHelper.packageInfo.buildNumber);
      if (buildCode == null || buildCode >= (Platform.isAndroid ? data.androidMinimumBuildCode : data.iosMinimumBuildCode)) {
        add(UserDataEvent());
      } else {
        emit(state.copyWith(splashStatus: StateStatus.success, nextPage: NextPage.update));
      }
    });
  }

  Future<void> _getUserInfo(Emitter<SplashState> emit) async {
    if (prefManager.isFirstLaunch) {
      emit(state.copyWith(splashStatus: StateStatus.success, nextPage: NextPage.setup));
    } else if (prefManager.getToken.isEmpty) {
      emit(state.copyWith(splashStatus: StateStatus.success, nextPage: NextPage.auth));
    } else {
      final result = await userInfoUseCase.callUseCase(NoParams());
      result.fold(
        (fail) => emit(state.copyWith(splashStatus: StateStatus.failure, errorMessage: fail.message)),
        (data) => emit(state.copyWith(splashStatus: StateStatus.success, nextPage: NextPage.main)),
      );
    }
  }
}
