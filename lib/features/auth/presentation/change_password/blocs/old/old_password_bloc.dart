import 'package:bloc/bloc.dart';

import 'old_password_event.dart';
import 'old_password_state.dart';

class OldPasswordBloc extends Bloc<OldPasswordEvent, OldPasswordState> {
  OldPasswordBloc() : super(OldPasswordState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<OldPasswordState> emit) async {
    emit(state.clone());
  }
}
