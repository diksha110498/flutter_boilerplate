import 'package:flutter_boilerplate/src/core/models/version.dart';

class AppVersionSingleton {
  static AppVersionSingleton? _instance; // Make it nullable

  Version? appVersion; // Make it nullable

  // Private constructor
  AppVersionSingleton._();

  // Getter for the singleton instance
  static AppVersionSingleton get instance {
    return _instance ??= AppVersionSingleton._();
  }

  // Initialize the appVersion field (if needed)
  void initializeAppVersion(Version version) {
    appVersion ??= version;
  }
}
