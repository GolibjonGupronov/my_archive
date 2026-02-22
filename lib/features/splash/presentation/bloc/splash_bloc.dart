import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_event.dart';
import 'package:my_archive/features/splash/presentation/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState()) {
    on<InitEvent>((event, emit) async {
      await _loadData(emit);
    });
  }

  Future<void> _loadData(Emitter<SplashState> emit) async {
    emit(state.copyWith(splashStatus: StateStatus.inProgress));
    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(splashStatus: StateStatus.success, nextPage: NextPage.auth));

  }
}
