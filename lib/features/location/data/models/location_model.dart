import '../../domain/entities/location.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.address,
    required super.latitude,
    required super.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'address': address, 'latitude': latitude, 'longitude': longitude};
  }
}
