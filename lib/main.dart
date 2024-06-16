import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/src/core/di/device_info_service.dart';
import 'package:flutter_boilerplate/src/core/environments/environment.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_boilerplate/src/core/img_picker/bloc/image_picker_bloc.dart';
import 'package:flutter_boilerplate/src/core/location/location_util_screen.dart';
import 'package:flutter_boilerplate/src/core/notifications/notification_service_helper.dart';
import 'modules/authentication_module/bloc/login_bloc.dart';
import 'modules/firebase_live_tracking_chat_module/location_change_notifier.dart';
import 'modules/static_page_module/bloc/static_page_bloc.dart';
import 'src/core/app/language.dart';
import 'src/core/app_utils/export.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

@pragma('vm:entry-point')
Future<void> onSelectNotification(String? payload) async {
  log("remoteMessage notification payload ${payload ?? ""}");
  if (payload == null || payload.isEmpty) return;
  Map<String, dynamic>? map = jsonDecode(payload);
  if (map == null) return;
  try {
  } catch (e) {
    print(e);
  }
  if (payload.contains("FLUTTER_NOTIFICATION_CLICK")) {
    try {
      print("map ${map}");
   //navigate to chat screen
    } catch (e) {
      print("chat notification error ${e}");
    }
  }
}

@pragma('vm:entry-point')
Future<void> onSelectBackgroundNotification(
    NotificationResponse notificationResponse) async {

}

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  serviceLocator();
  await setup();
  configLoading();
  const fatalError = true;
  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
  await SentryFlutter.init((options) {
    options.dsn =
        '';
  },
      // Init your App.
      appRunner: () => runApp(MyApp()));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..textColor = Colors.white
    ..boxShadow = [
      BoxShadow(color: Colors.transparent, spreadRadius: 0.0, blurRadius: 0.0)
    ]
    ..indicatorColor = Colors.transparent
    ..backgroundColor = AppColors.primaryColor.withOpacity(0.9)
    ..userInteractions = false
    ..indicatorWidget = SpinKitRipple(color: Colors.white)
    ..dismissOnTap = false;
}

Future<void> setup() async {
  await NotificationServiceHelper.instance.initialize();

  await getLocation();
  await ScreenUtil.ensureScreenSize();

  await getIt.get<Language>().loadAppLanguage();
  const environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.DEV,
  );
  Environment().initConfig(environment: environment);
  // Fetch device information using the singleton instance
  await DeviceInfoService.instance.fetchDeviceInfo();
}

getLocation() async {
  try {
    LocationUtilScreen.initializeLocationService();
  } catch (e) {
    print("unable to get location");
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = RoutesGenerator.initalRoute;

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocationChangeNotifier(),
        ),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => StaticPageBloc()),
        BlocProvider(create: (context) => ImagePickerBloc()),

      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        ensureScreenSize: true,
        useInheritedMediaQuery: true,
        builder: (_, child) {
          return MaterialApp(
            title: AppStrings.appName,
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RoutesGenerator.generateRoute,
            initialRoute: initialRoute,
            navigatorKey: NavigationService.navigatorKey,
            theme: AppTheme.lightTheme,
          );
        },
      ),
    );
  }
}
