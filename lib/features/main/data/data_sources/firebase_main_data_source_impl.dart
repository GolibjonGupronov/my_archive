import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_archive/core/api/error/exception.dart';
import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/features/main/data/data_sources/main_data_source.dart';

class FirebaseMainDataSourceImpl extends MainDataSource {
  final FirebaseFirestore firestore;
  final SecureStorage secureStorage;

  FirebaseMainDataSourceImpl({required this.firestore, required this.secureStorage});

  @override
  Future<bool> checkSession() async {
    final uid = await secureStorage.getToken;
    final deviceId = DeviceService.deviceId;

    return await AliceFirebase.logCall(
      name: "${FirebaseUrls.users}/${FirebaseUrls.deviceSessions}/checkSession",
      request: {"uid": uid, "device_id": deviceId},
      action: () async {
        final doc =
            await firestore.collection(FirebaseUrls.users).doc(uid).collection(FirebaseUrls.deviceSessions).doc(deviceId).get();

        if (!doc.exists) {
          throw UnAuthorizedException();
        }
        return true;
      },
    );
  }

  @override
  Future<Stream<bool>> watchSession() async {
    final uid = await secureStorage.getToken;
    final deviceId = DeviceService.deviceId;
    if (uid.isEmpty || deviceId.isEmpty) {
      return Stream.value(false);
    }
    return firestore
        .collection(FirebaseUrls.users)
        .doc(uid)
        .collection(FirebaseUrls.deviceSessions)
        .doc(deviceId)
        .snapshots()
        .map((snapshot) => snapshot.exists);
  }
}
