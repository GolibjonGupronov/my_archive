import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/use_cases/user_info_use_case.dart';
import 'package:my_archive/features/edit_profile/presentation/bloc/edit_profile_event.dart';
import 'package:my_archive/features/edit_profile/presentation/bloc/edit_profile_state.dart';
import 'package:my_archive/features/profile/domain/use_cases/edit_profile_use_case.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditProfileUseCase editProfileUseCase;
  final UserInfoUseCase userInfoUseCase;

  EditProfileBloc({required this.editProfileUseCase, required this.userInfoUseCase}) : super(EditProfileState()) {
    on<InitEvent>((event, emit) {
      final firstName = event.firstName ?? '';
      final secondName = event.secondName ?? '';
      final birthDay = event.birthDay;
      final gender = event.gender ?? Gender.male;

      final isActive = birthDay != null && firstName.trim().isNotEmpty && secondName.trim().isNotEmpty;

      emit(state.copyWith(
        firstName: firstName,
        secondName: secondName,
        birthDay: birthDay,
        gender: gender,
        isActive: isActive,
        initialFirstName: firstName,
        initialSecondName: secondName,
        initialBirthDay: birthDay,
        initialGender: gender,
      ));
    });

    on<UpdateFieldEvent>((event, emit) async {
      final firstName = event.firstName ?? state.firstName;
      final secondName = event.secondName ?? state.secondName;
      final birthDay = event.birthDay ?? state.birthDay;
      final gender = event.gender ?? state.gender;

      final isChanged = firstName != state.initialFirstName ||
          secondName != state.initialSecondName ||
          birthDay != state.initialBirthDay ||
          gender != state.initialGender;

      final isActive = birthDay != null && firstName.trim().isNotEmpty && secondName.trim().isNotEmpty;

      emit(state.copyWith(
        firstName: firstName,
        secondName: secondName,
        birthDay: birthDay,
        gender: gender,
        isActive: isActive,
        isChanged: isChanged,
      ));
    });

    on<SubmitEvent>(_submit);
  }

  Future<void> _submit(SubmitEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(editStatus: StateStatus.inProgress));
    final result = await editProfileUseCase.callUseCase(event.params);
    await result.fold((fail) async {
      emit(state.copyWith(editStatus: StateStatus.failure, errorMessage: fail.message));
    }, (data) async {
      final userResult = await userInfoUseCase.callUseCase(NoParams());
      userResult.fold((fail) {
        emit(state.copyWith(editStatus: StateStatus.failure, errorMessage: fail.message));
      }, (data) {
        emit(state.copyWith(editStatus: StateStatus.success));
      });
    });
  }
}
