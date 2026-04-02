import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/faq/domain/entities/faq_entity.dart';
import 'package:my_archive/features/faq/domain/repositories/faq_repository.dart';

class FaqUseCase extends UseCase<List<FaqEntity>, NoParams> {
  final FaqRepository repository;

  FaqUseCase({required this.repository});

  @override
  Future<Either<Failure, List<FaqEntity>>> callUseCase(NoParams params) async => await repository.faqList();
}
