import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/domain/repositories/profile_repository.dart';

class EnableNotificationUseCase extends UseCase<bool, bool> {
  final ProfileRepository repository;

  EnableNotificationUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> callUseCase(bool params) async => await repository.enableNotification(params);
}
