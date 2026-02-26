import 'package:bloc/bloc.dart';

import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<MainState> emit) async {
    emit(state.clone());
  }
}
