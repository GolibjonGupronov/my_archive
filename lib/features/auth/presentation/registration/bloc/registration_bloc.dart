import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/features/auth/presentation/registration/bloc/registration_event.dart';
import 'package:my_archive/features/auth/presentation/registration/bloc/registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationState().init()) {
    on<InitEvent>((event, emit) {});
  }
}
