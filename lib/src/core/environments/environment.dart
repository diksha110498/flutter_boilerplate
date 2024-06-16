import 'package:flutter_boilerplate/src/core/environments/base_config.dart';
import 'package:flutter_boilerplate/src/core/environments/dev_config.dart';
import 'package:flutter_boilerplate/src/core/environments/production_config.dart';
import 'package:flutter_boilerplate/src/core/environments/staging_config.dart';


//To load proper environment configuration in our Flutter app, we will create a class called Environment which can set configuration dynamically.
// To use this in your app where you are making HTTP call, pls use like below
// final String apiHost = Environment().config.apiHost;
class Environment {

  //singleton implementation
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String DEV = 'DEV';
  static const String STAGING = 'STAGING';
  static const String PROD = 'PROD';

  late BaseConfig config;

  void initConfig({required String environment}) {
    config = _getConfig(environment: environment);
  }

  BaseConfig _getConfig({required String environment}) {
    switch (environment) {
      case Environment.PROD:
        return ProductionConfig();
      case Environment.STAGING:
        return StagingConfig();
        case Environment.DEV:
        return DevConfig();
      default:
        return DevConfig();
    }
  }
}