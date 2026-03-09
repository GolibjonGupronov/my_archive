import 'package:bloc/bloc.dart';

import 'device_session_event.dart';
import 'device_session_state.dart';

class DeviceSessionBloc extends Bloc<DeviceSessionEvent, DeviceSessionState> {
  DeviceSessionBloc() : super(DeviceSessionState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<DeviceSessionState> emit) async {
    emit(state.clone());
  }
}
