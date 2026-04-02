import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/faq/data/data_source/faq_data_source.dart';
import 'package:my_archive/features/faq/domain/entities/faq_entity.dart';
import 'package:my_archive/features/faq/domain/repositories/faq_repository.dart';

class FaqRepositoryImpl with SafeCaller implements FaqRepository {
  final FaqDataSource faqDataSource;

  FaqRepositoryImpl({required this.faqDataSource});

  @override
  Future<Either<Failure, List<FaqEntity>>> faqList() {
    return safeCall(() async => await faqDataSource.faqList());
  }
}
