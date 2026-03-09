import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_archive/core/widgets/dialogs/custom_toast.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestCameraPermission() async => await _requestPermission(Permission.camera);

  static Future<bool> requestCameraPermissionWithToast(BuildContext context) async =>
      await _requestPermissionWithToast(permission: Permission.camera, context: context, message: tr('allow_access_camera'));

  static Future<bool> requestGalleryPermission() async => await _requestPermission(Permission.photos);

  static Future<bool> requestGalleryPermissionWithToast(BuildContext context) async =>
      await _requestPermissionWithToast(permission: Permission.photos, context: context, message: tr('allow_access_gallery'));

  static Future<bool> requestFilePermission() async => await _requestPermission(Permission.storage);

  static Future<bool> requestFilePermissionWithToast(BuildContext context) async =>
      await _requestPermissionWithToast(permission: Permission.storage, context: context, message: tr('allow_access_file'));

  static Future<bool> requestLocationPermission() async => await _requestPermission(Permission.location);

  static Future<bool> requestLocationPermissionWithToast(BuildContext context) async =>
      _requestPermissionWithToast(permission: Permission.location, context: context, message: tr('allow_access_location'));

  static Future<bool> _requestPermission(Permission permission) async {
    PermissionStatus status = await permission.status;

    if (status.isGranted) {
      return true;
    }

    status = await permission.request();

    return status.isGranted;
  }

  static Future<bool> _requestPermissionWithToast(
      {required Permission permission, required BuildContext context, required String message}) async {
    PermissionStatus status = await permission.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      final result = await permission.request();
      if (result.isGranted) {
        return true;
      } else if (result.isPermanentlyDenied) {
        showErrorToast(context, message, action: () async {
          await openAppSettings();
        });
      }
    } else if (status.isPermanentlyDenied) {
      showErrorToast(context, message, action: () async {
        await openAppSettings();
      });
    }

    return false;
  }
}
