// location_service.dart
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

Future<bool> requestLocationPermission() async {
  Location location = Location();
  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return false;
    }
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  return permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always;
}

Future<LatLng> getCurrentLocation() async {
  LocationData locationData = await Location().getLocation();
  return LatLng(locationData.latitude!, locationData.longitude!);
}
