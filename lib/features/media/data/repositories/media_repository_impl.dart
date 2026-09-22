import 'package:my_archive/core/exports/data_exports.dart';
import 'package:my_archive/features/media/data/data_sources/media_data_source.dart';
import 'package:my_archive/features/media/domain/entities/media_entity.dart';
import 'package:my_archive/features/media/domain/repositories/media_repository.dart';

class MediaRepositoryImpl with SafeCaller implements MediaRepository {
  final MediaDataSource mediaDataSource;

  MediaRepositoryImpl({required this.mediaDataSource});

  @override
  Future<Either<Failure, List<MediaEntity>>> getMedia(String params) {
    return safeCall(() => mediaDataSource.getMedia(params));
  }
}
