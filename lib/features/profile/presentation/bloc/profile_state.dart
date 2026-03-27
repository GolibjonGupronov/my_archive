import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/entities/user_info_entity.dart';

class ProfileState {
  final StateStatus changeImageStatus;
  final UserInfoEntity? user;
  final String userImage;
  final String errorMessage;
  final bool isGranted;
  final bool isNotificationEnabled;
  final bool isBiometricEnabled;

  ProfileState({
    this.changeImageStatus = StateStatus.initial,
    this.user,
    this.userImage = "",
    this.errorMessage = "",
    this.isGranted = false,
    this.isNotificationEnabled = true,
    this.isBiometricEnabled = false,
  });

  ProfileState copyWith({
    StateStatus? changeImageStatus,
    UserInfoEntity? user,
    String? userImage,
    String? errorMessage,
    bool? isGranted,
    bool? isNotificationEnabled,
    bool? isBiometricEnabled,
  }) {
    return ProfileState(
      changeImageStatus: changeImageStatus ?? this.changeImageStatus,
      user: user ?? this.user,
      userImage: userImage ?? this.userImage,
      errorMessage: errorMessage ?? this.errorMessage,
      isGranted: isGranted ?? this.isGranted,
      isNotificationEnabled: isNotificationEnabled ?? this.isNotificationEnabled,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
    );
  }
}
