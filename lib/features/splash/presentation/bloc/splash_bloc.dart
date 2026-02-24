import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/core/use_cases/usecase.dart';
import 'package:my_archive/features/auth/domain/use_cases/user_info_use_case.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_event.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final UserInfoUseCase userInfoUseCase;

  SplashBloc({required this.userInfoUseCase}) : super(SplashState()) {
    on<InitEvent>((event, emit) async {
      await _loadData(emit);
    });
  }

  Future<void> _loadData(Emitter<SplashState> emit) async {
    emit(state.copyWith(splashStatus: StateStatus.inProgress));

    final either = await userInfoUseCase.call(NoParams());
    either.fold(
      (fail) => emit(state.copyWith(splashStatus: StateStatus.failure, errorMessage: fail.message)),
      (data) {
        emit(state.copyWith(splashStatus: StateStatus.success, nextPage: NextPage.auth));
      },
    );
  }
}
