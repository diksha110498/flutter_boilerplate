import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/main.dart';
import 'package:flutter_boilerplate/src/core/app_utils/export.dart';
import 'package:flutter_boilerplate/src/core/app_utils/local_storage_constant.dart';
import 'notification_service.dart';


class NotificationServiceHelper extends NotificationService {
  static NotificationServiceHelper? _instance;
  GlobalKey<NavigatorState>? _globalKey;

  NotificationServiceHelper._() : super(notificationIcon: 'ic_notification');

  static NotificationServiceHelper get instance =>
      _instance ??= NotificationServiceHelper._();

  @override
  void setGlobalNavigationKey(GlobalKey<NavigatorState> globalKey) {
    _instance!._globalKey = globalKey;
  }

  @override
  void saveFCMToken(String? token) {
    log('FCM Token: $token');
    getIt.get<SharedPreferencesService>().setString(LocalStorageConstant.fcmTokenKey,token??'');
  }




}
