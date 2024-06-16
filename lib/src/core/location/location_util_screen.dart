import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' ;
import 'package:flutter_boilerplate/src/core/location/location_service.dart';
import 'package:flutter_boilerplate/src/core/location/user_location_singleton.dart';

class LocationUtilScreen {
  static LocationService _locationService = LocationService();
  static Future<void> _getLocation() async {
    LatLng ?location = await _locationService.getCurrentLocation();
    if (location != null) {
      UserLocationSingleton.instance.initialPosition = location;
      print("UserLocationSingleton.instance.initialPosition ${ UserLocationSingleton.instance.initialPosition}");
    }
  }

  static Future<void> initializeLocationService() async {
    bool hasPermission = await _locationService.requestLocationPermission();
    if (hasPermission) {
      await _getLocation();
    } /*else {

      EasyLoading.showToast(
          "Not able to get location, try after some time.");
    }*/
  }
}
