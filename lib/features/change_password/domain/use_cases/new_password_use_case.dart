import 'package:my_archive/core/exports/domain_exports.dart';
import 'package:my_archive/features/change_password/domain/repositories/change_password_repository.dart';

class NewPasswordUseCase extends UseCase<bool, String> {
  final ChangePasswordRepository repository;

  NewPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> callUseCase(String params) => repository.newPassword(params);
}
