import 'package:get_it/get_it.dart';
import 'package:flutter_boilerplate/src/core/connectivity/network_connection_observer.dart';
import 'package:flutter_boilerplate/src/core/local_storage/shared_preferences.dart';
import 'package:flutter_boilerplate/src/core/app/language.dart';

var getIt = GetIt.instance;

Future<void> serviceLocator() async {
  getIt.registerSingleton<NetworkConnectionObserver>(
      NetworkConnectionObserver());
  getIt.registerSingleton<Language>(Language());
  SharedPreferencesService sharedPrefs =
      await SharedPreferencesService.getInstance();
  getIt.registerSingleton<SharedPreferencesService>(sharedPrefs);
}
