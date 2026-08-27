import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_archive/core/api/api_urls/firebase_urls.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/data/data_sources/device_session_data_source.dart';
import 'package:my_archive/features/device_session/data/models/device_session_model.dart';

class FirebaseDeviceSessionDataSourceImpl extends DeviceSessionDataSource {
  final FirebaseFirestore firestore;
  final SecureStorage secureStorage;

  FirebaseDeviceSessionDataSourceImpl({required this.firestore, required this.secureStorage});

  @override
  Future<List<DeviceSessionModel>> getDeviceSessions() async {
    final uid = await secureStorage.getToken;
    final deviceId = DeviceService.deviceId;

    final snapshot = await firestore.collection(FirebaseUrls.users).doc(uid).collection(FirebaseUrls.deviceSessions).get();
    return snapshot.docs.map((e) {
      final session = DeviceSessionModel.fromJson(e.data());
      return session.copyWith(isCurrent: session.deviceId == deviceId);
    }).toList();
  }

  @override
  Future<bool> terminateDevice(String params) async {
    final uid = await secureStorage.getToken;
    final deviceId = DeviceService.deviceId;

    final sessionsRef = firestore.collection(FirebaseUrls.users).doc(uid).collection(FirebaseUrls.deviceSessions);

    if (params == "all") {
      final snapshot = await sessionsRef.get();

      final batch = firestore.batch();

      for (final doc in snapshot.docs) {
        final session = DeviceSessionModel.fromJson(doc.data());

        if (session.deviceId != deviceId) {
          batch.delete(doc.reference);
        }
      }

      await batch.commit();
    } else {
      await sessionsRef.doc(params).delete();
    }

    return true;
  }
}
