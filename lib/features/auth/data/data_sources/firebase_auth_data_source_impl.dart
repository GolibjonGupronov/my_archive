import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/data/data_sources/auth_data_source.dart';
import 'package:my_archive/features/auth/data/models/app_config_model.dart';
import 'package:my_archive/features/auth/data/models/user_info_model.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/login_use_case.dart';
import 'package:my_archive/features/auth/domain/use_cases/registration_use_case.dart';

class FirebaseAuthDataSourceImpl extends AuthDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final PrefManager prefManager;

  FirebaseAuthDataSourceImpl({required this.firebaseAuth, required this.firestore, required this.prefManager});

  @override
  Future<AppConfigModel> appConfig() async {
    final data = AppConfigModel(
        iosMinimumBuildCode: 1,
        androidMinimumBuildCode: 1,
        googlePlayLink: "https://play.google.com/store/apps/details?id=uz.evo_med_group.evo_med",
        appStoreLink: "https://apps.apple.com/us/app/evomed/id6758425374");
    return data;
  }

  @override
  Future<bool> checkSms(CheckSmsParams params) async {
    return true;
  }

  @override
  Future<UserInfoModel> getUserInfo({required bool isNotificationEnabled}) async {
    final uid = prefManager.getToken;

    final doc = await firestore.collection('users').doc(uid).get();

    if (doc.exists && doc.data() != null) {
      return UserInfoModel.fromJson(doc.data()!);
    } else {
      throw Exception("User data not found in Firestore");
    }
  }

  @override
  Future<bool> registration(RegistrationParams params) {
    // TODO: implement registration
    throw UnimplementedError();
  }

  @override
  Future<String> sendLogin(LoginParams params) async {
    final response = await firebaseAuth.signInWithEmailAndPassword(email: "${params.phone}@gmail.com", password: params.password);
    // developer.log(
    //   'Firebase signIn response',
    //   name: 'AuthService',
    //   error: response.toString(),
    // );
    return response.user?.uid ?? "";
  }

  @override
  Future<bool> sendPhone(String phone) {
    // TODO: implement sendPhone
    throw UnimplementedError();
  }
}
