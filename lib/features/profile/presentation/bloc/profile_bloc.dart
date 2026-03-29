import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/local_storage/secure_storage.dart';
import 'package:my_archive/features/auth/domain/use_cases/user_info_use_case.dart';
import 'package:my_archive/features/profile/domain/use_cases/change_image_use_case.dart';
import 'package:my_archive/features/profile/domain/use_cases/enable_notification_use_case.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_event.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final PrefManager prefManager;
  final ChangeImageUseCase changeImageUseCase;
  final EnableNotificationUseCase enableNotificationUseCase;
  final UserInfoUseCase userInfoUseCase;
  final SecureStorage secureStorage;

  ProfileBloc({required this.prefManager,
    required this.changeImageUseCase,
    required this.enableNotificationUseCase,
    required this.userInfoUseCase,
    required this.secureStorage,
  })
      : super(ProfileState()) {
    on<InitEvent>((event, emit) {
      add(CheckBiometricEvent());
      emit(state.copyWith(user: prefManager.getUserInfo, userImage: prefManager.getUserInfo?.image ?? ""));
    });

    on<IsGrantedEvent>((event, emit) async {
      bool isGranted = await PermissionService.requestNotificationPermission(canRequest: false);
      emit(state.copyWith(isGranted: isGranted));
    });

    on<EnableNotificationEvent>(
          (event, emit) async {
        if (state.isNotificationEnabled == event.value) return;
        emit(state.copyWith(isNotificationEnabled: event.value));

        await Future.delayed(const Duration(milliseconds: 500));
        if (emit.isDone) return;

        final result = await enableNotificationUseCase.callUseCase(event.value);
        if (emit.isDone) return;

        await result.fold((fail) async {
          if (emit.isDone) return;
          emit(state.copyWith(isNotificationEnabled: !event.value));
        }, (data) async {
          if (emit.isDone) return;
          final resultUser = await userInfoUseCase.callUseCase(NotificationParams(isNotificationEnabled: event.value));

          if (emit.isDone) return;
          resultUser.fold((fail) {}, (data) {
            emit(state.copyWith(isNotificationEnabled: data.isNotificationEnabled));
          });
        });
      },
      transformer: restartable(),
    );

    on<ToggleBiometricEvent>((event, emit) async {
      await prefManager.setBiometric(event.value);
      emit(state.copyWith(isBiometricEnabled: prefManager.isBiometric));
    });

    on<CheckBiometricEvent>((event, emit) async {
      emit(state.copyWith(isBiometricEnabled: prefManager.isBiometric));
    });

    on<ChangeImageEvent>((event, emit) async {
      emit(state.copyWith(changeImageStatus: StateStatus.inProgress, userImage: event.path));
      final result = await changeImageUseCase.callUseCase(event.path);
      result.fold(
              (fail) =>
              emit(state.copyWith(changeImageStatus: StateStatus.failure, userImage: prefManager.getUserInfo?.image ?? "")),
              (data) => emit(state.copyWith(changeImageStatus: StateStatus.success)));
    });
  }
}
