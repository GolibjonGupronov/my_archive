import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_archive/core/exports/core_exports.dart';

class LocationData {
  final double latitude;
  final double longitude;
  final String address;

  const LocationData({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }
}

class LocationService {
  LocationService._();

  static Future<LocationData?> getCurrentLocation() async {
    try {
      final position = await getCurrentPosition();

      if (position == null) {
        return null;
      }

      final placemark = await getPlacemark(latitude: position.latitude, longitude: position.longitude);

      final address = placemark != null ? _buildAddress(placemark) : null;

      return LocationData(latitude: position.latitude, longitude: position.longitude, address: address ?? "");
    } catch (e) {
      return null;
    }
  }

  static Future<Position?> getCurrentPosition() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        return null;
      }

      final hasPermission = await PermissionService.requestLocationPermission();

      if (!hasPermission) {
        return null;
      }

      return await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.high));
    } catch (e) {
      return null;
    }
  }

  static Future<Placemark?> getPlacemark({required double latitude, required double longitude}) async {
    try {
      final placemarks = await Geocoding().placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isEmpty) {
        return null;
      }

      return placemarks.first;
    } catch (e) {
      return null;
    }
  }

  static String? _buildAddress(Placemark placemark) {
    final parts = <String>[
      if (placemark.subLocality?.trim().isNotEmpty == true) placemark.subLocality!.trim(),
      if (placemark.locality?.trim().isNotEmpty == true) placemark.locality!.trim(),
      if (placemark.administrativeArea?.trim().isNotEmpty == true) placemark.administrativeArea!.trim(),
    ];

    if (parts.isEmpty) {
      return null;
    }

    return parts.join(', ');
  }
}
