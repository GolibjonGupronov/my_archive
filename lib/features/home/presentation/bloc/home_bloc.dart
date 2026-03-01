import 'package:bloc/bloc.dart';

import 'package:my_archive/features/home/presentation/bloc/home_event.dart';
import 'package:my_archive/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<HomeState> emit) async {
    emit(state.clone());
  }
}
