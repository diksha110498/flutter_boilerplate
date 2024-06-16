import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../src/core/location/user_location_singleton.dart';

class LocationChangeNotifier extends ChangeNotifier {
  Timer? _timer;

  Future<void> _changeLocation() async {
    try {
      Permission.location.status.then((value) async {
        if (value.isDenied) {
          await Permission.location.request();
          return;
        }
        if (value.isPermanentlyDenied) {
          await openAppSettings();
          return;
        }
        if (value.isRestricted) {
          await Permission.location.request();
          return;
        }
        if (value.isLimited) {
          await Permission.location.request();
          return;
        }
      }).onError((error, stackTrace) {
        print("error $error");
      });

      Position position = await Geolocator.getCurrentPosition();

      LatLng currentRiderLatLng = LatLng(position.latitude, position.longitude);
      print("currentRiderLatLng ${currentRiderLatLng}");
      UserLocationSingleton.instance.initialPosition = currentRiderLatLng;
      // FirebaseLiveChat.instance.updateRiderLocationCollection();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void startLocationUpdates() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      _changeLocation();
    });
  }

  void stopLocationUpdates() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
