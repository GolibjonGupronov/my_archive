import 'package:bloc/bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/faq/domain/use_cases/faq_use_case.dart';
import 'package:my_archive/features/faq/presentation/bloc/faq_event.dart';
import 'package:my_archive/features/faq/presentation/bloc/faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  final FaqUseCase faqUseCase;

  FaqBloc({required this.faqUseCase}) : super(FaqState()) {
    on<InitEvent>((event, emit) async {
      await _loadData(emit);
    });
  }

  Future<void> _loadData(Emitter<FaqState> emit) async {
    emit(state.copyWith(faqStatus: StateStatus.inProgress));
    final result = await faqUseCase.callUseCase(NoParams());
    result.fold((fail) {
      emit(state.copyWith(faqStatus: StateStatus.failure, errorMessage: fail.message));
    }, (data) {
      emit(state.copyWith(faqStatus: StateStatus.success, faqList: data));
    });
  }
}
