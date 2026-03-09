import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/presentation/bloc/device_session_bloc.dart';
import 'package:my_archive/features/device_session/presentation/bloc/device_session_event.dart';

class DeviceSessionPage extends StatelessWidget {
  const DeviceSessionPage({super.key});

  static const String tag = '/device_session_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DeviceSessionBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<DeviceSessionBloc>(context);

    return CustomScaffold(
      appBar: CustomAppBar("Qurilma sessiyasi"),
      body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoxContainer(
                  borderRadius: BorderRadius.circular(8.r),
                  padding: EdgeInsets.all(4.w),
                  color: AppColors.primary,
                  child: Icon(
                    Icons.apple,
                    size: 30.w,
                    color: AppColors.white,
                  ),
                ),
                12.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextView("${(DeviceHelper.androidInfo?.brand ?? "").capitalize} ${DeviceHelper.androidInfo?.model}"),
                      TextView(
                          "${Platform.operatingSystem.capitalize} ${DeviceHelper.packageInfo.version}, ${Platform.operatingSystem.capitalize} ${DeviceHelper.androidInfo?.version.release} (${DeviceHelper.androidInfo?.version.sdkInt})",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                      TextView("Tashkent, Uzbekistan", fontSize: 14.sp, color: AppColors.gray, fontWeight: FontWeight.w400),
                    ],
                  ),
                ),
                8.width,
                TextView("15/08", color: AppColors.gray)
                // Icon(Icons.android_rounded)
              ],
            );
          },
          separatorBuilder: (c, i) => Divider(height: 40.h),
          itemCount: 3),
    );
  }
}
