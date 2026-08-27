import 'package:my_archive/features/faq/data/models/faq_model.dart';

abstract class FaqDataSource {
  Future<List<FaqModel>> faqList();
}
