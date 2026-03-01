import 'package:bloc/bloc.dart';
import 'package:my_archive/features/main/presentation/bloc/main_event.dart';
import 'package:my_archive/features/main/presentation/bloc/main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<InitEvent>((event, emit) {});

    on<ActiveMainPageEvent>((event, emit) {
      emit(state.copyWith(activePage: event.activePage));
    });
  }
}
