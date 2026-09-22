import 'package:my_archive/core/exports/domain_exports.dart';
import 'package:my_archive/features/media/domain/entities/media_entity.dart';

abstract class MediaRepository {
  Future<Either<Failure, List<MediaEntity>>> getMedia(String params);
}
