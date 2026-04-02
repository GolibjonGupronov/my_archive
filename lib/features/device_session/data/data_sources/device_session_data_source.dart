import 'package:dio/dio.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/data/models/device_session_model.dart';
import 'package:my_archive/features/device_session/domain/entities/device_session_entity.dart';

abstract class DeviceSessionDataSource {
  Future<List<DeviceSessionModel>> getDeviceSessions();
  Future<bool> terminateDevice(int params);
}

class DeviceSessionDataSourceImpl extends DeviceSessionDataSource {
  final Dio dio;

  DeviceSessionDataSourceImpl({required this.dio});

  @override
  Future<List<DeviceSessionModel>> getDeviceSessions() async {
    final response = await dio.mock(data: _deviceSessions).post(ApiUrls.deviceSessionList);
    return (response.data as List<dynamic>).map((e) => DeviceSessionModel.fromJson(e)).toList();
  }

  @override
  Future<bool> terminateDevice(int params) async {
    final response = await dio.mock(data: true).post(ApiUrls.terminateDevice);
    return response.data;
  }
}

List<DeviceSessionModel> get _deviceSessions => [
      DeviceSessionModel(
        id: 1,
        deviceName: "${(DeviceHelper.androidInfo?.brand ?? "").capitalize} ${DeviceHelper.androidInfo?.model}",
        operatingSystemType: OperatingSystemType.android,
        appVersion: DeviceHelper.packageInfo.version,
        releaseVersion: DeviceHelper.androidInfo?.version.release ?? "",
        sdk: "${DeviceHelper.androidInfo?.version.sdkInt ?? 0}",
        address: "Tashkent, Uzbekistan",
        dateTime: "24/02/2026",
        isCurrent: true,
      ),
      DeviceSessionModel(
        id: 2,
        deviceName: "Iphone 17 Pro Max",
        operatingSystemType: OperatingSystemType.ios,
        appVersion: "1.2.4",
        releaseVersion: "26.3",
        sdk: "12",
        address: "Tashkent, Uzbekistan",
        dateTime: "28/02/2026",
        isCurrent: false,
      ),
      DeviceSessionModel(
        id: 3,
        deviceName: "${(DeviceHelper.androidInfo?.brand ?? "").capitalize} ${DeviceHelper.androidInfo?.model}",
        operatingSystemType: OperatingSystemType.android,
        appVersion: DeviceHelper.packageInfo.version,
        releaseVersion: DeviceHelper.androidInfo?.version.release ?? "",
        sdk: "${DeviceHelper.androidInfo?.version.sdkInt ?? 0}",
        address: "Tashkent, Uzbekistan",
        dateTime: "27/02/2026",
        isCurrent: false,
      ),
      DeviceSessionModel(
        id: 4,
        deviceName: "Iphone 17 Pro Max",
        operatingSystemType: OperatingSystemType.ios,
        appVersion: "1.2.4",
        releaseVersion: "26.3",
        sdk: "12",
        address: "Tashkent, Uzbekistan",
        dateTime: "28/02/2026",
        isCurrent: false,
      ),
    ];
