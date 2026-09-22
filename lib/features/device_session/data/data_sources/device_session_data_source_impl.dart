import 'package:dio/dio.dart';
import 'package:my_archive/core/api/dio/dio_mock.dart';
import 'package:my_archive/core/exports/data_exports.dart';
import 'package:my_archive/features/device_session/data/data_sources/device_session_data_source.dart';
import 'package:my_archive/features/device_session/data/models/device_session_model.dart';

class DeviceSessionDataSourceImpl extends DeviceSessionDataSource {
  final Dio dio;

  DeviceSessionDataSourceImpl({required this.dio});

  @override
  Future<List<DeviceSessionModel>> getDeviceSessions() async {
    final response = await dio.mock(data: []).post(ApiUrls.deviceSessionList);
    return (response.data as List<dynamic>).map((e) => DeviceSessionModel.fromJson(e)).toList();
  }

  @override
  Future<bool> terminateDevice(String params) async {
    final response = await dio.mock(data: true).post(ApiUrls.terminateDevice);
    return response.data;
  }
}
