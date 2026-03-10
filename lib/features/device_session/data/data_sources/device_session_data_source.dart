import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/data/models/device_session_model.dart';

abstract class DeviceSessionDataSource {
  Future<List<DeviceSessionModel>> getDeviceSessions();
}

class DeviceSessionDataSourceImpl extends DeviceSessionDataSource {
  final Dio dio;

  DeviceSessionDataSourceImpl({required this.dio});

  @override
  Future<List<DeviceSessionModel>> getDeviceSessions() async {
    final response = await dio.mock(data: _deviceSessions).post(ApiUrls.deviceSessionList);
    return (response.data as List<dynamic>).map((e) => DeviceSessionModel.fromJson(e)).toList();
  }
}

List<DeviceSessionModel> get _deviceSessions => [
      DeviceSessionModel(
        deviceName: "${(DeviceHelper.androidInfo?.brand ?? "").capitalize} ${DeviceHelper.androidInfo?.model}",
        operatingSystem: Platform.operatingSystem.capitalize,
        appVersion: DeviceHelper.packageInfo.version,
        releaseVersion: DeviceHelper.androidInfo?.version.release ?? "",
        sdk: "${DeviceHelper.androidInfo?.version.sdkInt ?? 0}",
        address: "Tashkent, Uzbekistan",
        dateTime: "29.02.2000",
      )
    ];
