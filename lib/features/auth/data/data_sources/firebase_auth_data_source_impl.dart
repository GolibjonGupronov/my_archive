import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_archive/core/api/api_urls/firebase_urls.dart';
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
  final SecureStorage secureStorage;

  String _verificationId = "";

  FirebaseAuthDataSourceImpl({required this.firebaseAuth, required this.firestore, required this.secureStorage});

  @override
  Future<AppConfigModel> appConfig() async {
    final doc = await firestore.collection(FirebaseUrls.appConfig).doc(FirebaseUrls.appConfigId).get();
    if (doc.exists && doc.data() != null) {
      return AppConfigModel.fromJson(doc.data()!);
    } else {
      throw Exception("App Config topilmadi");
    }
  }

  @override
  Future<bool> checkSms(CheckSmsParams params) async {
    return true;
  }

  @override
  Future<UserInfoModel> getUserInfo() async {
    final uid = await secureStorage.getToken;

    final doc = await firestore.collection(FirebaseUrls.users).doc(uid).get();

    if (doc.exists && doc.data() != null) {
      return UserInfoModel.fromJson(doc.data()!);
    } else {
      throw Exception("User data not found in Firestore");
    }
  }

  @override
  Future<bool> registration(RegistrationParams params) async {
    final verificationId = _verificationId;

    if (verificationId.isEmpty) {
      throw FirebaseAuthException(code: 'verification-id-null', message: 'Verification ID topilmadi.');
    }

    final userCredential = await firebaseAuth
        .signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId, smsCode: params.smsCode));

    final user = userCredential.user;

    if (user == null) {
      throw FirebaseAuthException(code: 'user-null', message: 'User yaratilmadi.');
    }

    final email = "${params.phone}@gmail.com";

    final hasPasswordProvider = user.providerData.any((provider) => provider.providerId == 'password');

    if (!hasPasswordProvider) {
      await user.linkWithCredential(EmailAuthProvider.credential(email: email, password: params.smsCode));
    }

    final uid = user.uid;

    await firestore.collection(FirebaseUrls.users).doc(uid).set(params.toMap);

    return true;
  }

  @override
  Future<String> sendLogin(LoginParams params) async {
    final response = await firebaseAuth.signInWithEmailAndPassword(email: "${params.phone}@gmail.com", password: params.password);
    final user = response.user;

    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-null',
        message: 'User topilmadi.',
      );
    }

    final uid = user.uid;
    await _saveDeviseSession(uid);
    return uid;
  }

  @override
  Future<bool> sendPhone(String phone) async {
    final completer = Completer<bool>();

    try {
      final userQuery = await firestore.collection(FirebaseUrls.users).where('phone', isEqualTo: phone).limit(1).get();

      if (userQuery.docs.isNotEmpty) {
        logger("GGQ => User already exists: $phone");

        if (!completer.isCompleted) {
          completer.completeError("Bu telefon raqami allaqachon ro‘yxatdan o‘tgan.");
        }

        return completer.future;
      }

      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        // 1. Avtomatik tasdiqlash (asosan Android-da)
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Agar avtomatik tasdiqlansa, bu yerda ham true qaytarsa bo'ladi
          // Lekin ko'p hollarda codeSent-ni kutish kifoya
        },
        // 2. Xatolik yuz berganda
        verificationFailed: (FirebaseAuthException e) {
          logger("GGQ => Firebase Auth Error: ${e.message}");
          if (!completer.isCompleted) {
            completer.completeError(e);
          }
        },
        // 3. SMS yuborilganda (Asosiy qism)
        codeSent: (String verificationId, int? resendToken) {
          // MUHIM: verificationId ni biror joyga (masalan, class field-ga)
          // saqlab qo'yishingiz kerak, chunki kodni tasdiqlashda u kerak bo'ladi.
          _verificationId = verificationId;
          logger("GGQ => SMS muvaffaqiyatli yuborildi. ID: $verificationId");
          if (!completer.isCompleted) {
            completer.complete(true);
          }
        },
        // 4. Avtomatik qidirish vaqti tugaganda
        codeAutoRetrievalTimeout: (String verificationId) {
          logger("GGQ => Auto retrieval timeout");
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      logger("GGQ => Send Phone Error: $e");
      if (!completer.isCompleted) {
        completer.completeError(e);
      }
    }

    return completer.future;
  }

  Future<void> _saveDeviseSession(String uid) async {
    final deviceId = DeviceService.deviceId;

    if (deviceId.isEmpty) {
      throw Exception('Device ID topilmadi');
    }
    final sessionRef = firestore.collection(FirebaseUrls.users).doc(uid).collection(FirebaseUrls.deviceSessions).doc(deviceId);
    final snapshot = await sessionRef.get();
    final address = await LocationService.getCurrentLocation();
    if (!snapshot.exists) {
      await sessionRef.set({
        'device_id': deviceId,
        'device_name': DeviceService.deviceModel,
        'operating_system': OperatingSystemType.current.key,
        'app_version': DeviceService.packageInfo.version,
        'release_version': DeviceService.osVersion,
        'address': address?.toJson(),
        'date_time': FieldValue.serverTimestamp(),
        'is_current': false,
      });
    } else {
      await sessionRef.update({
        'address': address?.toJson(),
        'date_time': FieldValue.serverTimestamp(),
        'is_current': false,
      });
    }
  }
}
