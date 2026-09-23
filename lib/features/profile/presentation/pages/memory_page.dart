import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/core/extensions/enum_ui.dart';
import 'package:my_archive/core/utils/logger.dart';
import 'package:my_archive/features/profile/presentation/blocs/memory/memory_bloc.dart';
import 'package:my_archive/features/profile/presentation/blocs/memory/memory_event.dart';
import 'package:my_archive/features/profile/presentation/blocs/memory/memory_state.dart';

class MemoryPage extends StatelessWidget {
  static const String tag = '/memory_page';

  const MemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MemoryBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    logger("GGQ => MemoryPage");
    final bloc = BlocProvider.of<MemoryBloc>(context);

    return CustomScaffold(
      appBar: CustomAppBar("Xotira"),
      body: BlocBuilder<MemoryBloc, MemoryState>(
        builder: (context, state) {
          if (state.sizeStatus.isInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              state.folderTotalSize == 0
                  ? Column(
                      children: [
                        20.height,
                        Icon(CupertinoIcons.checkmark_seal_fill, color: AppColors.primary, size: 150.w),
                        16.height,
                        TextView("Xotira tozalandi"),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200.h,
                            child: Stack(
                              children: [
                                PieChart(
                                  PieChartData(
                                      sections: state.folderPercent.entries
                                          .map(
                                            (e) => PieChartSectionData(
                                              cornerRadius: 30.r,
                                              value: e.value,
                                              title: "${e.value.fixed(fix: 1)} %",
                                              color: _getColor(e.key),
                                              titleStyle: AppTheme.textTheme.titleLarge?.copyWith(color: AppColors.white),
                                            ),
                                          )
                                          .toList()),
                                ),
                                Center(
                                    child: TextView(formatBytes(state.folderTotalSize), style: AppTheme.textTheme.displayLarge))
                              ],
                            ),
                          ),
                          16.height,
                          BoxContainer(
                            borderRadius: BorderRadius.circular(12.r),
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final entry = state.folderBytes.entries.elementAt(index);
                                  return Row(
                                    children: [
                                      Icon(
                                          entry.value == 0.0
                                              ? CupertinoIcons.checkmark_circle
                                              : CupertinoIcons.check_mark_circled_solid,
                                          size: 21.w,
                                          color: _getColor(entry.key)),
                                      4.width,
                                      TextView(entry.key.title),
                                      Expanded(child: TextView(formatBytes(entry.value), textAlign: TextAlign.end)),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) => Divider(),
                                itemCount: state.folderBytes.entries.length),
                          ),
                          16.height,
                          CustomButton("Tozalash", () {
                            bloc.add(ClearFolderEvent());
                          })
                        ],
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}

Color _getColor(FolderType type) {
  switch (type) {
    case FolderType.video:
      return AppColors.primary;
    case FolderType.audio:
      return AppColors.pink;
    case FolderType.image:
      return AppColors.orange;
    case FolderType.file:
      return AppColors.green;
  }
}
