import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/faq/data/data_source/faq_data_source.dart';
import 'package:my_archive/features/faq/data/repositories/faq_repository_impl.dart';
import 'package:my_archive/features/faq/domain/repositories/faq_repository.dart';
import 'package:my_archive/features/faq/domain/use_cases/faq_use_case.dart';

void initFaqInjection() {
  sl.registerSingleton<FaqDataSource>(FaqDataSourceImpl(dio: sl()));
  sl.registerSingleton<FaqRepository>(FaqRepositoryImpl(faqDataSource: sl()));
  sl.registerSingleton<FaqUseCase>(FaqUseCase(repository: sl()));
}
