import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/main/domain/use_cases/check_session_use_case.dart';
import 'package:my_archive/features/main/presentation/bloc/main_event.dart';
import 'package:my_archive/features/main/presentation/bloc/main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final CheckSessionUseCase checkSessionUseCase;

  MainBloc({required this.checkSessionUseCase}) : super(MainState()) {
    on<InitEvent>((event, emit) {
      checkSessionUseCase.callUseCase(NoParams());
    });

    on<ActiveMainPageEvent>((event, emit) {
      emit(state.copyWith(activePage: event.activePage));
    });
  }
}
