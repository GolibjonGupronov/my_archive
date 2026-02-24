import 'package:my_archive/core/api/error/failure.dart';
import 'package:my_archive/core/api/error/safe_caller.dart';
import 'package:my_archive/core/local_storage/pref_manager/pref_manager.dart';
import 'package:my_archive/core/utils/either.dart';
import 'package:my_archive/features/auth/data/data_sources/auth_data_source.dart';
import 'package:my_archive/features/auth/data/models/user_info_model.dart';
import 'package:my_archive/features/auth/domain/entities/send_phone_response_entity.dart';
import 'package:my_archive/features/auth/domain/entities/user_info_entity.dart';
import 'package:my_archive/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';

class AuthRepositoryImpl with SafeCaller implements AuthRepository {
  final AuthDataSource authRemoteDataSource;
  final PrefManager prefManager;

  AuthRepositoryImpl({required this.authRemoteDataSource, required this.prefManager});

  @override
  Future<Either<Failure, SendPhoneResponseEntity>> sendPhone(String phone) async {
    return safeCall<SendPhoneResponseEntity>(() async => await authRemoteDataSource.sendPhone(phone));
  }

  @override
  Future<Either<Failure, bool>> checkSms(CheckSmsParams params) {
    return safeCall<bool>(() async => await authRemoteDataSource.checkSms(params));
  }

  @override
  Future<Either<Failure, UserInfoEntity>> getUser() {
    return safeCall2<UserInfoEntity, UserInfoModel>(
      () async => await authRemoteDataSource.getUserInfo(),
      onSuccess: (data) async {
        await prefManager.setUserInfo(data);
      },
    );
  }
}
