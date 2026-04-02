import 'package:flutter/cupertino.dart';
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
      create: (BuildContext context) =>
          DeviceSessionBloc(deviceSessionUseCase: sl(), terminateDeviceUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<DeviceSessionBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<DeviceSessionBloc, DeviceSessionState>(
          listenWhen: (p, c) => p.sessionStatus != c.sessionStatus,
          listener: (context, state) {
            if (state.sessionStatus.isFailure) {
              showErrorDialog(context, title: state.errorMessage);
            }
          },
        ),
        BlocListener<DeviceSessionBloc, DeviceSessionState>(
          listenWhen: (p, c) => p.terminateStatus != c.terminateStatus,
          listener: (context, state) {
            if (state.terminateStatus.isSuccess) {
              bloc.add(LoadDataEvent());
            } else if (state.terminateStatus.isFailure) {
              showErrorDialog(context, title: state.errorMessage);
            }
          },
        ),
      ],
      child: CustomScaffold(
        appBar: CustomAppBar("Qurilma sessiyasi"),
        body: BlocBuilder<DeviceSessionBloc, DeviceSessionState>(
          builder: (context, state) {
            final progress = state.sessionStatus.isInProgress || state.terminateStatus.isInProgress;
            return (state.noDevice && !progress)
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
                : Padding(
                    padding: EdgeInsets.all(8.w),
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(left: 8.w, bottom: 8.h), child: TextView("Hozirgi qurilma")),
                            BoxContainer(
                              borderRadius: BorderRadius.circular(20.r),
                              padding: EdgeInsets.all(12.w),
                              child: Column(
                                children: [
                                  Builder(builder: (context) {
                                    if (progress) return SessionShimmerItem();
                                    return state.activeDevice != null ? DeviceSessionItem(item: state.activeDevice!) : SizedBox();
                                  }),
                                  8.height,
                                  Bounce(
                                    onTap: () {
                                      if (!progress) {
                                        showRejectDialog(context, "Barcha sessiyalarni to'xtatish",
                                            subTitle: "Haqiqatdan ham barcha sessiyalarni tugatmoqchimisiz?", onConfirm: () {
                                          bloc.add(TerminateAllEvent());
                                        });
                                      }
                                    },
                                    child: BoxContainer(
                                      padding: EdgeInsets.all(4.w),
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(CupertinoIcons.hand_raised_fill, color: AppColors.white),
                                          8.width,
                                          TextView("Boshqa barcha sessiyalarni to'xtatish", color: AppColors.white),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 8.w, bottom: 12.h, top: 12.h),
                                child: TextView("Boshqa qurilmalar")),
                            canShowEmpty(state.noActiveDevices, progress)
                                ? Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.phonelink_off_rounded, size: 64.w),
                                        12.height,
                                        TextView("Boshqa qurilmalar yo'q"),
                                      ],
                                    ),
                                  )
                                : BoxContainer(
                                    borderRadius: BorderRadius.circular(20.r),
                                    padding: EdgeInsets.all(12.w),
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemBuilder: (context, index) {
                                          if (progress) return SessionShimmerItem();
                                          final item = state.noActiveDevices[index];
                                          return Bounce(
                                              onTap: () {
                                                if (!progress) {
                                                  showRejectDialog(context, "Ushbu sessiyani to'xtatish",
                                                      subTitle: "Haqiqatdan ham ushbu \"${item.deviceName}\" sessiyani tugatmoqchimisiz?",
                                                      onConfirm: () {
                                                    bloc.add(TerminateDeviceEvent(id: item.id));
                                                  });
                                                }
                                              },
                                              child: DeviceSessionItem(item: item));
                                        },
                                        separatorBuilder: (c, i) => Divider(height: 40.h),
                                        itemCount: progress ? 3 : state.noActiveDevices.length),
                                  ),
                          ],
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
