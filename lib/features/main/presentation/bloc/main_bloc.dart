import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/services/logout_service.dart';
import 'package:my_archive/features/main/domain/use_cases/check_session_use_case.dart';
import 'package:my_archive/features/main/domain/use_cases/watch_session_use_case.dart';
import 'package:my_archive/features/main/presentation/bloc/main_event.dart';
import 'package:my_archive/features/main/presentation/bloc/main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final CheckSessionUseCase checkSessionUseCase;
  final WatchSessionUseCase watchSessionUseCase;
  StreamSubscription<bool>? _sessionSubscription;

  MainBloc({required this.checkSessionUseCase, required this.watchSessionUseCase}) : super(MainState()) {
    on<InitEvent>((event, emit) async {
      await checkSessionUseCase.callUseCase(NoParams());
      add(WatchSessionEvent());
    });

    on<ActiveMainPageEvent>((event, emit) {
      emit(state.copyWith(activePage: event.activePage));
    });

    on<WatchSessionEvent>(_onWatchSession);
    on<SessionExpiredEvent>((event, emit) async {
      await LogoutService.logoutApp();
    });
  }

  Future<void> _onWatchSession(WatchSessionEvent event, Emitter<MainState> emit) async {
    await _sessionSubscription?.cancel();

    final result = await watchSessionUseCase.callUseCase(NoParams());

    result.fold(
      (failure) => null,
      (stream) {
        _sessionSubscription = stream.listen((isAlive) {
          if (!isAlive) {
            add(SessionExpiredEvent());
          }
        });
      },
    );
  }

  @override
  Future<void> close() {
    _sessionSubscription?.cancel();
    return super.close();
  }
}
