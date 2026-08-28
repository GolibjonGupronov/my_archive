import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/features/device_session/domain/repositories/device_session_repository.dart';

class TerminateDeviceUseCase extends UseCase<bool, String> {
  final DeviceSessionRepository repository;

  TerminateDeviceUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> callUseCase(String params) async => await repository.terminateDevice(params);
}