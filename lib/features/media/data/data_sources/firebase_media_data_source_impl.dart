import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_archive/core/exports/data_exports.dart';
import 'package:my_archive/core/local_storage/secure_storage.dart';
import 'package:my_archive/features/media/data/data_sources/media_data_source.dart';
import 'package:my_archive/features/media/data/models/media_model.dart';

class FirebaseMediaDataSourceImpl extends MediaDataSource {
  final FirebaseFirestore firestore;
  final SecureStorage secureStorage;

  FirebaseMediaDataSourceImpl({required this.firestore, required this.secureStorage});

  @override
  Future<List<MediaModel>> getMedia(String params) async {
    final uid = await secureStorage.getToken;
    return AliceFirebase.logCall(
      name: "${FirebaseUrls.users}/${FirebaseUrls.media}",
      request: {"uid": params},
      action: () async {
        final snapshot = await firestore.collection(FirebaseUrls.users).doc(uid).collection(FirebaseUrls.media).get();

        return snapshot.docs.map((e) {
          return MediaModel.fromJson(e.data());
        }).toList();
      },
    );
  }
}
