import 'package:permission_handler/permission_handler.dart';

class HandlePermission {
  static Future<bool> get cameraIsGranted async {
    PermissionStatus status = await Permission.camera.status;
    if (status.isGranted) return true;

    status = await Permission.camera.request();
    return status.isGranted;
  }

  static Future<bool> get locationIsGranted async {
    // final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   // Geolocator.openLocationSettings();
    //   return false;
    // }
    //
    // LocationPermission permission = await Geolocator.checkPermission();
    //
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     return false;
    //   }
    // }
    //
    // if (permission == LocationPermission.deniedForever) {
    //   // Geolocator.openAppSettings();
    //   return false;
    // }
    //
    // return true;
    var status = await Permission.location.status;
    if (status.isGranted) return true;

    status = await Permission.location.request();
    return status.isGranted;
  }
}
