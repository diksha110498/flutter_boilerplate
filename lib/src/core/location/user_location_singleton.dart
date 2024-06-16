import 'package:google_maps_flutter/google_maps_flutter.dart';
class UserLocationSingleton {
  static UserLocationSingleton? _instance;
  LatLng? initialPosition;

  UserLocationSingleton._();

  static UserLocationSingleton get instance {
    return _instance ??= UserLocationSingleton._();
  }
}
