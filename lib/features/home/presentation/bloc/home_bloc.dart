import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/home/presentation/bloc/home_event.dart';
import 'package:my_archive/features/home/presentation/bloc/home_state.dart';
import 'package:my_archive/features/story/domain/use_cases/story_list_use_case.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StoryListUseCase storyListUseCase;

  HomeBloc({required this.storyListUseCase}) : super(HomeState()) {
    on<InitEvent>((event, emit) {
      debugPrint("GGQ => HomeBloc InitEvent");
      add(StoryListEvent());
    });

    on<StoryListEvent>((event, emit) async {
      emit(state.copyWith(storyStatus: StateStatus.inProgress));
      final result = await storyListUseCase.callUseCase(NoParams());
      result.fold((fail) => emit(state.copyWith(storyStatus: StateStatus.failure, errorMessage: fail.message)), (data) {
        emit(state.copyWith(storyStatus: StateStatus.success, storyList: data));
      });
    });
  }
}
