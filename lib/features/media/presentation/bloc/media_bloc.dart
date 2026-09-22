import 'package:bloc/bloc.dart';
import 'package:my_archive/features/media/domain/use_cases/media_use_case.dart';
import 'package:my_archive/features/media/presentation/bloc/media_event.dart';
import 'package:my_archive/features/media/presentation/bloc/media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final MediaUseCase mediaUseCase;

  MediaBloc({required this.mediaUseCase}) : super(MediaState()) {
    on<InitEvent>((event, emit) {});
  }
}
