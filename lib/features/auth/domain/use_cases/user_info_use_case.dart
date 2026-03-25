import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/entities/user_info_entity.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';

class UserInfoUseCase extends UseCase<UserInfoEntity, NoParams> {
  final AuthRepository repository;

  UserInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, UserInfoEntity>> callUseCase(NoParams params) async {
    bool isEnabled = true;

    if (params is NotificationParams) {
      isEnabled = params.isNotificationEnabled;
    }

    return await repository.getUserInfo(isNotificationEnabled: isEnabled);
  }
}

class NotificationParams extends NoParams {
  final bool isNotificationEnabled;

  NotificationParams({required this.isNotificationEnabled});

  @override
  List<Object> get props => [isNotificationEnabled];
}
