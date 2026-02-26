import 'package:my_archive/core/api/error/failure.dart';
import 'package:my_archive/core/use_cases/usecase.dart';
import 'package:my_archive/core/utils/either.dart';
import 'package:my_archive/features/auth/domain/entities/app_config_entity.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';

class AppConfigUseCase extends UseCase<AppConfigEntity, NoParams>{
  final AuthRepository repository;

  AppConfigUseCase({required this.repository});
  @override
  Future<Either<Failure, AppConfigEntity>> call(NoParams params) async => await repository.appConfig();
}