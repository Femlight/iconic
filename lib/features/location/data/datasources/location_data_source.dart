import 'package:location/location.dart';
import '../models/location_model.dart';

abstract class LocationDataSource {
  Future<LocationModel> getCurrentLocation();
  Future<List<LocationModel>> searchAddress(String query);
}

class LocationDataSourceImpl implements LocationDataSource {
  final Location location;

  LocationDataSourceImpl({required this.location});

  @override
  Future<LocationModel> getCurrentLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception('Location service is disabled');
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception('Location permission denied');
      }
    }

    final locationData = await location.getLocation();

    // Mock reverse geocoding - in real app, use geocoding service
    final address =
        'Lat: ${locationData.latitude?.toStringAsFixed(4)}, Lng: ${locationData.longitude?.toStringAsFixed(4)}';

    return LocationModel(
      address: address,
      latitude: locationData.latitude!,
      longitude: locationData.longitude!,
    );
  }

  @override
  Future<List<LocationModel>> searchAddress(String query) async {
    // Mock address search - in real app, use geocoding service
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      LocationModel(
        address: query,
        latitude: 37.7749 + (query.length * 0.001),
        longitude: -122.4194 + (query.length * 0.001),
      ),
    ];
  }
}
