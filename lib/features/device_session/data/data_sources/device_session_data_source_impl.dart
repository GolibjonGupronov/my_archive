import 'package:dio/dio.dart';
import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/features/device_session/data/data_sources/device_session_data_source.dart';
import 'package:my_archive/features/device_session/data/models/device_session_model.dart';
import 'package:my_archive/features/device_session/data/models/location_model.dart';

class DeviceSessionDataSourceImpl extends DeviceSessionDataSource {
  final Dio dio;

  DeviceSessionDataSourceImpl({required this.dio});

  @override
  Future<List<DeviceSessionModel>> getDeviceSessions() async {
    final response = await dio.mock(data: _deviceSessions).post(ApiUrls.deviceSessionList);
    return (response.data as List<dynamic>).map((e) => DeviceSessionModel.fromJson(e)).toList();
  }

  @override
  Future<bool> terminateDevice(String params) async {
    final response = await dio.mock(data: true).post(ApiUrls.terminateDevice);
    return response.data;
  }
}

List<DeviceSessionModel> get _deviceSessions => [
      DeviceSessionModel(
        deviceId: "1",
        deviceName: DeviceService.deviceModel,
        operatingSystemType: OperatingSystemType.android,
        appVersion: DeviceService.packageInfo.version,
        releaseVersion: DeviceService.osVersion,
        address: LocationModel.fromJson({}),
        dateTime: "24/02/2026",
        isCurrent: true,
      ),
      DeviceSessionModel(
        deviceId: "2",
        deviceName: "Iphone 17 Pro Max",
        operatingSystemType: OperatingSystemType.ios,
        appVersion: "1.2.4",
        releaseVersion: "26.3",
        address: LocationModel.fromJson({}),
        dateTime: "28/02/2026",
        isCurrent: false,
      ),
      DeviceSessionModel(
        deviceId: "3",
        deviceName: DeviceService.deviceModel,
        operatingSystemType: OperatingSystemType.android,
        appVersion: DeviceService.packageInfo.version,
        releaseVersion: DeviceService.osVersion,
        address: LocationModel.fromJson({}),
        dateTime: "27/02/2026",
        isCurrent: false,
      ),
      DeviceSessionModel(
        deviceId: "4",
        deviceName: "Iphone 17 Pro Max",
        operatingSystemType: OperatingSystemType.ios,
        appVersion: "1.2.4",
        releaseVersion: "26.3",
        address: LocationModel.fromJson({}),
        dateTime: "28/02/2026",
        isCurrent: false,
      ),
    ];
