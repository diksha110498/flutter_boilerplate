import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';


class DeviceInfoService {
  static DeviceInfoService? _instance;
  static DeviceInfoService get instance {
    return _instance ??= DeviceInfoService._();
  }

  // Private constructor
  DeviceInfoService._();

  // Property to hold device information
  DeviceInfoDataModel _deviceInfo = DeviceInfoDataModel();

  DeviceInfoDataModel get deviceInfo => _deviceInfo;

  // Method to fetch device information
  Future<void> fetchDeviceInfo() async {
    try {
      PackageInfo packageInfoPlugin =await PackageInfo.fromPlatform();
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        _deviceInfo = DeviceInfoDataModel.fromJson({
          'device_id': androidInfo.id,
          'platform': 'Android',
          'app_version': packageInfoPlugin.version, // Replace with your actual app version
          'device_brand': androidInfo.brand,
          'device_model': androidInfo.model,
          'device_os': androidInfo.version.release,
        });
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        _deviceInfo =  DeviceInfoDataModel.fromJson({
          'device_id': iosInfo.identifierForVendor,
          'platform': 'iOS',
          'app_version': packageInfoPlugin.version, // Replace with your actual app version
          'device_brand': 'Apple',
          'device_model': iosInfo.utsname.machine,
          'device_os': iosInfo.systemVersion,
        });
      }
    } catch (e) {
      // Handle exceptions
      print('Error getting device information: $e');
    }
  }
}


class DeviceInfoDataModel{
  String ?deviceId;
  String ?platform;
  String ?appVersion;
  String ?deviceBrand;
  String ?deviceModel;
  String ?deviceOS;
  DeviceInfoDataModel({this.deviceId, this.platform, this.appVersion,
    this.deviceBrand, this.deviceModel, this.deviceOS});

  DeviceInfoDataModel.fromJson(Map<String,dynamic> data):
    deviceId=data['device_id'],
    platform=data['platform'],
    appVersion=data['app_version'],
    deviceBrand=data['device_brand'],
    deviceModel=data['device_model'],
    deviceOS=data['device_os'];
  }
