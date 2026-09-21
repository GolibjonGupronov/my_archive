import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
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
              SizedBox(
                height: 200.h,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: state.videosPercent,
                        title: state.videosPercent.formattedAmount,
                        color: AppColors.blue,
                        titleStyle: AppTheme.textTheme.titleMedium?.copyWith(color: AppColors.white),
                      ),
                      PieChartSectionData(
                        value: state.audiosPercent,
                        title: state.audiosPercent.formattedAmount,
                        color: AppColors.red,
                        titleStyle: AppTheme.textTheme.titleMedium?.copyWith(color: AppColors.white),
                      ),
                      PieChartSectionData(
                        value: state.imagesPercent,
                        title: state.imagesPercent.formattedAmount,
                        color: AppColors.red,
                        titleStyle: AppTheme.textTheme.titleMedium?.copyWith(color: AppColors.white),
                      ),
                      // PieChartSectionData(value: 10),
                      // PieChartSectionData(value: 10),
                    ],
                  ),
                ),
              ),
              TextView("folderMbSize: ${state.folderMbSize}"),
              TextView("videosMb: ${state.videosMb}"),
              TextView("audiosMb: ${state.audiosMb}"),
              TextView("imagesMb: ${state.imagesMb}"),
              TextView("freeDiskSpace: ${state.freeDiskSpace/1024}"),
              TextView("totalDiskSpace: ${state.totalDiskSpace/1024}"),
              CustomButton("Tozalash", (){
                bloc.add(ClearFolderEvent());
              })
            ],
          );
        },
      ),
    );
  }
}
