import 'package:my_archive/features/device_session/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.latitude,
    required super.longitude,
    required super.address,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    latitude: json['latitude'] ?? 0.0,
    longitude: json['longitude'] ?? 0.0,
    address: json['address'] ?? "",
  );

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'address': address,
  };
}
