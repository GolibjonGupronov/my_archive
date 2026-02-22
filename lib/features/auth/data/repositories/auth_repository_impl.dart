import 'package:my_archive/core/api/error/failure.dart';
import 'package:my_archive/core/api/error/safe_caller.dart';
import 'package:my_archive/core/utils/either.dart';
import 'package:my_archive/features/auth/data/data_sources/auth_data_source.dart';
import 'package:my_archive/features/auth/domain/entities/send_phone_response_entity.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_archive/features/auth/domain/use_cases/send_phone_use_case.dart';

class AuthRepositoryImpl with SafeCaller implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  // @override
  // Future<Either<Failure, SendPhoneResponseEntity>> sendPhone(SendPhoneParams params) async {
  //   return safeBaseCall<SendPhoneResponseEntity>(
  //     call: () async => await authDataSource.sendPhone(params),
  //     mapper: (data) => SendPhoneResponseModel.fromJson(data).toEntity,
  //   );
  // }

  @override
  Future<Either<Failure, SendPhoneResponseEntity>> sendPhone(SendPhoneParams params) async {
    return await safeCall(() async {
      return await authDataSource.sendPhone(params);
    });
  }
}
