import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';

import 'edit_profile_event.dart';
import 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileState()) {
    on<InitEvent>((event, emit) {
      final firstName = event.firstName ?? '';
      final secondName = event.secondName ?? '';
      final birthDay = event.birthDay;
      final gender = event.gender ?? Gender.male;

      final isActive = birthDay != null && firstName.trim().isNotEmpty && secondName.trim().isNotEmpty;

      emit(state.copyWith(firstName: firstName, secondName: secondName, birthDay: birthDay, gender: gender, isActive: isActive));
    });

    on<UpdateFieldEvent>((event, emit) async {
      final firstName = event.firstName ?? state.firstName;
      final secondName = event.secondName ?? state.secondName;
      final birthDay = event.birthDay ?? state.birthDay;
      final gender = event.gender ?? state.gender;

      final isActive = birthDay != null && firstName.trim().isNotEmpty && secondName.trim().isNotEmpty;

      emit(state.copyWith(firstName: firstName, secondName: secondName, birthDay: birthDay, gender: gender, isActive: isActive));
    });

    on<SubmitEvent>((event, emit) async {});
  }
}
