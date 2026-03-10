import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/domain/entities/device_session_entity.dart';
import 'package:my_archive/features/device_session/domain/repositories/device_session_repository.dart';

class DeviceSessionUseCase extends UseCase<List<DeviceSessionEntity>, NoParams> {
  final DeviceSessionRepository repository;

  DeviceSessionUseCase({required this.repository});

  @override
  Future<Either<Failure, List<DeviceSessionEntity>>> callUseCase(NoParams params) async => await repository.getDeviceSessions();
}
