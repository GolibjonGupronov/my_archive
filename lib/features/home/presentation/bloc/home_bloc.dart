import 'package:bloc/bloc.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/core/use_cases/use_case.dart';
import 'package:my_archive/features/home/presentation/bloc/home_event.dart';
import 'package:my_archive/features/home/presentation/bloc/home_state.dart';
import 'package:my_archive/features/media/domain/use_cases/media_use_case.dart';
import 'package:my_archive/features/story/domain/use_cases/story_list_use_case.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StoryListUseCase storyListUseCase;
  final MediaUseCase mediaUseCase;

  HomeBloc({required this.storyListUseCase, required this.mediaUseCase}) : super(HomeState()) {
    on<InitEvent>((event, emit) {
      add(StoryListEvent());
      add(MediaListEvent());
    });

    on<StoryListEvent>((event, emit) async {
      emit(state.copyWith(storyStatus: StateStatus.inProgress));
      final result = await storyListUseCase.callUseCase(NoParams());
      result.fold((fail) => emit(state.copyWith(storyStatus: StateStatus.failure, errorMessage: fail.message)), (data) {
        emit(state.copyWith(storyStatus: StateStatus.success, storyList: data));
      });
    });

    on<MediaListEvent>((event, emit) async {
      emit(state.copyWith(mediaStatus: StateStatus.inProgress));
      final result = await mediaUseCase.callUseCase("");
      result.fold((fail) => emit(state.copyWith(mediaStatus: StateStatus.failure, errorMessage: fail.message)), (data) {
        emit(state.copyWith(mediaStatus: StateStatus.success, mediaList: data));
      });
    });
  }
}
