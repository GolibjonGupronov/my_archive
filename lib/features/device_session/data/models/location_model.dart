import 'package:my_archive/features/device_session/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.latitude,
    required super.longitude,
    required super.address,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        address: json['address'] as String,
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      };
}
