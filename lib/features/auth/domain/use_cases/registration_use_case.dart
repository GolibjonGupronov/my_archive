import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';

class RegistrationUseCase extends UseCase<bool, RegistrationParams> {
  final AuthRepository repository;

  RegistrationUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> callUseCase(RegistrationParams params) async => await repository.registration(params);
}

class RegistrationParams {
  final String phone;
  final String firstName;
  final String secondName;
  final Gender gender;
  final DateTime birthDay;
  final String smsCode;

  const RegistrationParams({
    required this.phone,
    required this.firstName,
    required this.secondName,
    required this.gender,
    required this.birthDay,
    required this.smsCode,
  });

  Map<String, dynamic> get toMap => {
        'phone': phone,
        'first_name': firstName,
        'second_name': secondName,
        'gender': gender.key,
        'birth_day': birthDay.toBackendDate,
        'smsCode': smsCode,
      };

  RegistrationParams copyWith({
    String? phone,
    String? smsCode,
  }) =>
      RegistrationParams(
        smsCode: smsCode ?? this.smsCode,
        phone: phone ?? this.phone,
        firstName: firstName,
        secondName: secondName,
        gender: gender,
        birthDay: birthDay,
      );
}
