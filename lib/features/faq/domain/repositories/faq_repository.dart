import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/faq/domain/entities/faq_entity.dart';

abstract class FaqRepository {
  Future<Either<Failure, List<FaqEntity>>> faqList();
}
