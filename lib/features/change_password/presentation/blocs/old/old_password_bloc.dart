import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/change_password/domain/use_cases/old_password_use_case.dart';
import 'package:my_archive/features/change_password/presentation/blocs/old/old_password_event.dart';
import 'package:my_archive/features/change_password/presentation/blocs/old/old_password_state.dart';

class OldPasswordBloc extends Bloc<OldPasswordEvent, OldPasswordState> {
  final OldPasswordUseCase oldPasswordUseCase;

  OldPasswordBloc({required this.oldPasswordUseCase}) : super(OldPasswordState()) {
    on<InitEvent>((event, emit) {});
    on<UpdateFieldEvent>((event, emit) {
      final password = event.password ?? state.password;
      emit(state.copyWith(password: password, isActive: password.trim().length >= Constants.passwordLength));
    });
    on<SubmitEvent>((event, emit) async {
      emit(state.copyWith(passwordStatus: StateStatus.inProgress));
      final result = await oldPasswordUseCase.callUseCase(event.password);
      result.fold((fail) {
        emit(state.copyWith(passwordStatus: StateStatus.failure, errorMessage: fail.message));
      }, (data) {
        emit(state.copyWith(passwordStatus: StateStatus.success));
        emit(OldPasswordState());
      });
    });
  }
}
