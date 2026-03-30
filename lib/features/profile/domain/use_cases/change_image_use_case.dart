import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/domain/repositories/profile_repository.dart';

class ChangeImageUseCase extends UseCase<String, String> {
  final ProfileRepository repository;

  ChangeImageUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> callUseCase(String params) async => await repository.changeImage(params);
}
