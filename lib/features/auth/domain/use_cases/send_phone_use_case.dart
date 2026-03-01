import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';

class SendPhoneUseCase extends UseCase<bool, String> {
  final AuthRepository repository;

  SendPhoneUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> callUseCase(String phone) async => await repository.sendPhone(phone);
}
