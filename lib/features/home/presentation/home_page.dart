import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/home/presentation/bloc/home_bloc.dart';
import 'package:my_archive/features/home/presentation/bloc/home_event.dart';
import 'package:my_archive/features/home/presentation/bloc/home_state.dart';
import 'package:my_archive/features/story/domain/entities/story_entity.dart';
import 'package:my_archive/features/story/presentation/widgets/story_list_shimmer.dart';
import 'package:my_archive/features/story/presentation/widgets/story_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeBloc(storyListUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (p, c) => p.storyStatus != c.storyStatus,
          listener: (context, state) {
            if (state.storyStatus.isFailure) {
              showErrorDialog(context, title: state.errorMessage);
            }
          },
        ),
      ],
      child: CustomScaffold(
        appBar: CustomAppBar(tr('home')),
        body: CustomScrollView(
          controller: ScrollController(),
          slivers:[
            SliverToBoxAdapter(
              child: BlocSelector<HomeBloc, HomeState, ({StateStatus storyStatus, List<StoryEntity> storyList})>(
                selector: (state) => (storyStatus: state.storyStatus, storyList: state.storyList),
                builder: (context, state) {
                  if (state.storyStatus.isInProgress) {
                    return StoryListShimmer();
                  }
                  return StoryListView(storyList: state.storyList);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
