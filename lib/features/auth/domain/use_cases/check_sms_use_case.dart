import 'package:my_archive/core/api/error/failure.dart';
import 'package:my_archive/core/use_cases/usecase.dart';
import 'package:my_archive/core/utils/either.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';

class CheckSmsUseCase extends UseCase<bool, CheckSmsParams> {
  final AuthRepository repository;

  CheckSmsUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(CheckSmsParams params) {
    return repository.checkSms(params);
  }
}

class CheckSmsParams {
  final String phone;
  final String sms;

  CheckSmsParams({required this.phone,required this.sms});

  Map<String, dynamic> get toMap => {
    'phone': phone,
    'sms': sms,
  };
}