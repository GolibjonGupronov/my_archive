import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/change_password/domain/repositories/change_password_repository.dart';

class OldPasswordUseCase extends UseCase<bool, String> {
  final ChangePasswordRepository repository;

  OldPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> callUseCase(String params) async => await repository.oldPassword(params);
}
