import 'package:my_archive/core/api/error/failure.dart';
import 'package:my_archive/core/use_cases/usecase.dart';
import 'package:my_archive/core/utils/either.dart';
import 'package:my_archive/features/auth/domain/entities/user_info_entity.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';

class UserInfoUseCase extends UseCase<UserInfoEntity, NoParams> {
  final AuthRepository repository;

  UserInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, UserInfoEntity>> call(NoParams params) {
    return repository.getUser();
  }
}
