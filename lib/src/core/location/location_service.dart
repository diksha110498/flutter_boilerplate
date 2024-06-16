import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<LatLng?> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  Future<bool> requestLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.location.status;
    if (permissionStatus.isPermanentlyDenied ||
        permissionStatus.isLimited ||
        permissionStatus.isRestricted) {
      Geolocator.openLocationSettings();
      return false;
    }
    if (permissionStatus != PermissionStatus.granted) {
      return await Permission.location.request() == PermissionStatus.granted;
    }
    return true;
  }
}
