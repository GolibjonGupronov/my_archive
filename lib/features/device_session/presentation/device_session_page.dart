import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/presentation/bloc/device_session_bloc.dart';
import 'package:my_archive/features/device_session/presentation/bloc/device_session_event.dart';
import 'package:my_archive/features/device_session/presentation/bloc/device_session_state.dart';
import 'package:my_archive/features/device_session/presentation/widgets/device_session_item.dart';
import 'package:my_archive/features/device_session/presentation/widgets/session_shimmer_item.dart';

class DeviceSessionPage extends StatelessWidget {
  const DeviceSessionPage({super.key});

  static const String tag = '/device_session_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DeviceSessionBloc(deviceSessionUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<DeviceSessionBloc>(context);

    return BlocListener<DeviceSessionBloc, DeviceSessionState>(
      listenWhen: (p, c) => p.sessionStatus != c.sessionStatus,
      listener: (context, state) {
        if (state.sessionStatus.isFailure) {
          showErrorDialog(context, title: state.errorMessage);
        }
      },
      child: CustomScaffold(
        appBar: CustomAppBar("Qurilma sessiyasi"),
        body: BlocBuilder<DeviceSessionBloc, DeviceSessionState>(
          builder: (context, state) {
            return state.sessionStatus.isInProgress
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    itemBuilder: (context, index) => SessionShimmerItem(),
                    separatorBuilder: (c, i) => Divider(height: 40.h),
                    itemCount: 3)
                : state.deviceSessions.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.phonelink_off_rounded, size: 64.w),
                            12.height,
                            TextView("Qurilma biriktirilmagan"),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        itemBuilder: (context, index) {
                          final item = state.deviceSessions[index];
                          return DeviceSessionItem(item: item);
                        },
                        separatorBuilder: (c, i) => Divider(height: 40.h),
                        itemCount: state.deviceSessions.length);
          },
        ),
      ),
    );
  }
}
