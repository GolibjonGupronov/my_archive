import 'package:bloc/bloc.dart';

import 'package:my_archive/features/profile/presentation/bloc/profile_event.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<ProfileState> emit) async {
    emit(state.clone());
  }
}
