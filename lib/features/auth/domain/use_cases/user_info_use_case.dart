import 'package:my_archive/core/exports/domain_exports.dart';
import 'package:my_archive/features/auth/domain/entities/user_info_entity.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';

class UserInfoUseCase extends UseCase<UserInfoEntity, NoParams> {
  final AuthRepository repository;

  UserInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, UserInfoEntity>> callUseCase(NoParams params) => repository.getUserInfo();
}
