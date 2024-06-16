
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AppOneSignal {
  static const _appId = "36f1b5e1-a360-44df-9b78-e0fb0c153aa8";

  static AppOneSignal? _instance;
  GlobalKey<NavigatorState> _navigatorKey;

  AppOneSignal._(this._navigatorKey) {
    initOneSignal();
  }

  static void intialize(GlobalKey<NavigatorState> _navigatorKey) {
    _instance ??= AppOneSignal._(_navigatorKey);
  }

  static AppOneSignal? instance() {
    if (_instance == null) {
      throw Exception("AppOneSignal is not initialized");
    }
    return _instance;
  }

  Future<void> initOneSignal() async {
    if (kDebugMode) {
      //Remove this method to stop OneSignal Debugging
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    }
    OneSignal.initialize(_appId);
    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt.
    // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.Notifications.requestPermission(true);

    OneSignal.Notifications.addClickListener((event) {
      print('==NOTIFICATION CLICK LISTENER CALLED WITH EVENT==: $event');
      print("In Clicked: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
    });
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      print('NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');

      /// Display Notification, preventDefault to not display
      event.preventDefault();

      /// Do async work
      /// notification.display() to display after preventing default
      event.notification.display();

    });
  }
  void _handleLogin(String externalId) {
    print("Setting external user ID");
    OneSignal.login(externalId);
  }


}
