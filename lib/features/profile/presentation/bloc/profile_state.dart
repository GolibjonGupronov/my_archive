import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/entities/user_info_entity.dart';

class ProfileState {
  final StateStatus changeImageStatus;
  final UserInfoEntity? user;
  final String userImage;
  final String errorMessage;

  ProfileState({
    this.changeImageStatus = StateStatus.initial,
    this.user,
    this.userImage = "",
    this.errorMessage = "",
  });

  ProfileState copyWith({
    StateStatus? changeImageStatus,
    UserInfoEntity? user,
    String? userImage,
    String? errorMessage,
  }) {
    return ProfileState(
      changeImageStatus: changeImageStatus ?? this.changeImageStatus,
      user: user ?? this.user,
      userImage: userImage ?? this.userImage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
