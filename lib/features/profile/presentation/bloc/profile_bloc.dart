import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/domain/use_cases/change_image_use_case.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_event.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final PrefManager prefManager;
  final ChangeImageUseCase changeImageUseCase;

  ProfileBloc({required this.prefManager, required this.changeImageUseCase}) : super(ProfileState()) {
    on<InitEvent>((event, emit) {
      emit(state.copyWith(user: prefManager.getUserInfo, userImage: prefManager.getUserInfo?.image ?? ""));
    });

    on<ChangeImageEvent>((event, emit) async {
      emit(state.copyWith(changeImageStatus: StateStatus.inProgress, userImage: event.path));
      final result = await changeImageUseCase.callUseCase(event.path);
      result.fold(
          (fail) => emit(state.copyWith(changeImageStatus: StateStatus.failure, userImage: prefManager.getUserInfo?.image ?? "")),
          (data) => emit(state.copyWith(changeImageStatus: StateStatus.success)));
    });
  }
}
