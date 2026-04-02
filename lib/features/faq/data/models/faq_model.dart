import 'package:my_archive/features/faq/domain/entities/faq_entity.dart';

class FaqModel extends FaqEntity {
  FaqModel({
    required super.question,
    required super.answer,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      question: json['question'] ?? "",
      answer: json['answer'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}
