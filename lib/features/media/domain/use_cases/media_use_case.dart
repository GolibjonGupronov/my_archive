import 'package:my_archive/core/exports/domain_exports.dart';
import 'package:my_archive/features/media/domain/entities/media_entity.dart';
import 'package:my_archive/features/media/domain/repositories/media_repository.dart';

class MediaUseCase extends UseCase<List, String>{
  final MediaRepository repository;

  MediaUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MediaEntity>>> callUseCase(String params) => repository.getMedia(params);
}