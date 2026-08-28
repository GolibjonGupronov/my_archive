import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_archive/core/api/api_urls/firebase_urls.dart';
import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/features/edit_profile/data/data_sources/edit_profile_data_source.dart';
import 'package:my_archive/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';

class FirebaseEditProfileDataSourceImpl extends EditProfileDataSource {
  final FirebaseFirestore firestore;
  final SecureStorage secureStorage;

  FirebaseEditProfileDataSourceImpl({required this.firestore, required this.secureStorage});

  @override
  Future<bool> editProfile(EditProfileParams params) async {
    final uid = await secureStorage.getToken;
    final doc = firestore.collection(FirebaseUrls.users).doc(uid);
    await doc.update(params.toMap);
    return true;
  }

}
