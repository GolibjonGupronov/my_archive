import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';

class CheckSmsUseCase extends UseCase<bool, CheckSmsParams> {
  final AuthRepository repository;

  CheckSmsUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> callUseCase(CheckSmsParams params) async => await repository.checkSms(params);
}

class CheckSmsParams {
  final String phone;
  final String sms;

  CheckSmsParams({required this.phone, required this.sms});

  Map<String, dynamic> get toMap => {'phone': phone, 'sms': sms};
}
