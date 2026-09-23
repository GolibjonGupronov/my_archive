import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/di/injection_container.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/core/utils/logger.dart';
import 'package:my_archive/features/home/presentation/bloc/home_bloc.dart';
import 'package:my_archive/features/home/presentation/bloc/home_event.dart';
import 'package:my_archive/features/home/presentation/bloc/home_state.dart';
import 'package:my_archive/features/media/domain/entities/media_entity.dart';
import 'package:my_archive/features/media/presentation/widgets/media_list_view.dart';
import 'package:my_archive/features/story/domain/entities/story_entity.dart';
import 'package:my_archive/features/story/presentation/widgets/story_list_shimmer.dart';
import 'package:my_archive/features/story/presentation/widgets/story_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          HomeBloc(storyListUseCase: sl(), mediaUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    logger("GGQ => HomePage");
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (p, c) => p.storyStatus != c.storyStatus || p.mediaStatus != c.mediaStatus,
          listener: (context, state) {
            if (state.storyStatus.isFailure) {
              showErrorDialog(context, title: state.errorMessage);
            }
            if (state.mediaStatus.isFailure) {
              showErrorDialog(context, title: state.errorMessage);
            }
          },
        ),
      ],
      child: CustomScaffold(
        appBar: CustomAppBar(tr('home'), showBackButton: false),
        body: Column(
          children: [
            BlocSelector<HomeBloc, HomeState, ({StateStatus storyStatus, List<StoryEntity> storyList})>(
              selector: (state) => (storyStatus: state.storyStatus, storyList: state.storyList),
              builder: (context, state) {
                if (state.storyStatus.isInProgress) {
                  return StoryListShimmer();
                }
                return StoryListView(storyList: state.storyList);
              },
            ),
            12.height,
            Expanded(
              child: BlocSelector<HomeBloc, HomeState, ({StateStatus mediaStatus, List<MediaEntity> mediaList})>(
                selector: (state) => (mediaStatus: state.mediaStatus, mediaList: state.mediaList),
                builder: (context, state) {
                  if (state.mediaStatus.isInProgress) {
                    return CupertinoActivityIndicator();
                  }
                  return MediaListView(mediaList: state.mediaList);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
