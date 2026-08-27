import 'package:my_archive/features/device_session/data/models/device_session_model.dart';

abstract class DeviceSessionDataSource {
  Future<List<DeviceSessionModel>> getDeviceSessions();

  Future<bool> terminateDevice(String params);
}
