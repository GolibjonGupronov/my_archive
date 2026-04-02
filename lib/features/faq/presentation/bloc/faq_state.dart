import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/faq/domain/entities/faq_entity.dart';

class FaqState {
  final StateStatus faqStatus;
  final List<FaqEntity> faqList;
  final String errorMessage;

  const FaqState({
    this.faqStatus = StateStatus.initial,
    this.faqList = const [],
    this.errorMessage = '',
  });

  FaqState copyWith({
    StateStatus? faqStatus,
    List<FaqEntity>? faqList,
    String? errorMessage,
  }) =>
      FaqState(
        faqStatus: faqStatus ?? this.faqStatus,
        faqList: faqList ?? this.faqList,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
