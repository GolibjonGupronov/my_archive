import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_archive/core/api/api_urls/firebase_urls.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/data/data_sources/profile_data_source.dart';

class FirebaseProfileDataSourceImpl extends ProfileDataSource {
  final FirebaseFirestore firestore;
  final PrefManager prefManager;

  FirebaseProfileDataSourceImpl({required this.firestore, required this.prefManager});

  @override
  Future<String> changeImage(String params) {
    // TODO: implement changeImage
    throw UnimplementedError();
  }

  @override
  Future<bool> enableNotification(bool params) async {
    final uid = prefManager.getToken;
    final doc = firestore.collection(FirebaseUrls.users).doc(uid);
    await doc.update({'is_notification_enabled' : params});
    return true;
  }
}