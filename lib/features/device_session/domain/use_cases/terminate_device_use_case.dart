import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/domain/repositories/device_session_repository.dart';

class TerminateDeviceUseCase extends UseCase<bool, int> {
  final DeviceSessionRepository repository;

  TerminateDeviceUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> callUseCase(int params) async => await repository.terminateDevice(params);
}