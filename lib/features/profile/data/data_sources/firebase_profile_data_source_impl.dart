import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/features/profile/data/data_sources/profile_data_source.dart';

class FirebaseProfileDataSourceImpl extends ProfileDataSource {
  final FirebaseFirestore firestore;
  final SecureStorage secureStorage;

  FirebaseProfileDataSourceImpl({required this.firestore, required this.secureStorage});

  @override
  Future<String> changeImage(String params) {
    // TODO: implement changeImage
    throw UnimplementedError();
  }

  @override
  Future<bool> enableNotification(bool params) async {
    final uid = await secureStorage.getToken;

    return await AliceFirebase.logCall(
      name: "${FirebaseUrls.users}/enableNotification",
      request: {"uid": uid, "is_notification_enabled": params},
      action: () async {
        final doc = firestore.collection(FirebaseUrls.users).doc(uid);
        await doc.update({'is_notification_enabled': params});
        return true;
      },
    );
  }
}
