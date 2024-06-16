
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/core/app_utils/app_utils.dart';
import 'package:flutter_boilerplate/src/core/connectivity/network_connection_observer.dart';
import 'package:flutter_boilerplate/src/core/app/language.dart';
import 'package:flutter_boilerplate/src/core/local_storage/shared_preferences.dart';
import '../di/service_locator.dart';


abstract class BaseState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {

  final NetworkConnectionObserver network = getIt.get<NetworkConnectionObserver>();
  final Language language = getIt.get<Language>();
  final SharedPreferencesService sharedPrefs =  getIt.get<SharedPreferencesService>();

  @override
  Widget build(BuildContext context);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkUserLoggedIn();
  }

  bool checkUserLoggedIn(){
    return sharedPrefs.getBool('isLoggedIn');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        //print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        //print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        //print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
       // print('appLifeCycleState detached');
        break;
      case AppLifecycleState.hidden:
        //print('appLifeCycleState detached');
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}

