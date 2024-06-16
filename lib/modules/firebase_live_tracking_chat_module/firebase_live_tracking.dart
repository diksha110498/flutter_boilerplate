// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_boilerplate/src/core/app_utils/export.dart';
// import 'package:flutter_boilerplate/src/core/singleton/brand_version_singleton.dart';
//
// import '../../src/core/app_utils/local_storage_constant.dart';
// import '../../src/core/location/user_location_singleton.dart';
//
// class FirebaseLiveChat {
//   static FirebaseLiveChat? _instance;
//
//   FirebaseLiveChat._();
//
//   String _userCollection = 'users';
//   String _serviceProvidersCollection = 'service_providers';
//   String _chatRoomCollection = 'chat_room';
//   String _bookingCartSubCollection = 'booking_cart';
//   String _messagesSubCollection = 'messages';
//
//   static FirebaseLiveChat get instance {
//     return _instance ??= FirebaseLiveChat._();
//   }
//
//  Future<void> updateRiderLocationCollection() async {
//     ServiceProviderDetailsModel? serviceProviderDataModel =  getIt
//         .get<SharedPreferencesService>()
//         .getServiceProviderData(LocalStorageConstant.serviceProviderDataKey);
//     Map<String, dynamic> param = {};
//
//     param['latitude'] = UserLocationSingleton.instance.initialPosition?.latitude;
//     param['longitude'] = UserLocationSingleton.instance.initialPosition?.longitude;
//     param['name'] = "${serviceProviderDataModel?.firstName} ${serviceProviderDataModel?.lastName}";
//     param['platform'] = Platform.isAndroid ? 'android' : 'ios';
//     param['token'] =
//     getIt
//         .get<SharedPreferencesService>()
//         .getString(LocalStorageConstant.fcmTokenKey);
//
//     FirebaseFirestore.instance
//         .collection(
//    _serviceProvidersCollection) // rider is the main collection, which will have the multiple riders list
//         .doc(serviceProviderDataModel?.id?.toString())
//         .set(param)
//         .then((_) {
//     }).catchError((error) {
//       print("----------Location----an error occurred--------------==$error");
//     });
//   }
//
//   Future<void> createFirebaseUserInCollection() async {
//     UserDataModel? userDataModel =  getIt
//         .get<SharedPreferencesService>()
//         .getUserData(LocalStorageConstant.userDataKey);
//     String? deviceId = DeviceInfoService.instance.deviceInfo.deviceId;
//     String deviceToken = getIt
//         .get<SharedPreferencesService>()
//         .getString(LocalStorageConstant.fcmTokenKey);
//     Map<String, dynamic> paramMap = {
//       'user_id': userDataModel!.id,
//       'user_name': "${userDataModel.firstName} ${userDataModel.lastName}",
//       'device_id': deviceId,
//       'device_token': deviceToken,
//       "platform": Platform.isIOS ? "IOS" : "Android",
//     };
//     FirebaseFirestore.instance
//         .collection(_userCollection)
//         .doc(userDataModel.id.toString())
//         .set(paramMap)
//         .then((_) {
//       print("-------------collection created-------------");
//     }).catchError((error) {
//       print("--------------an error occurred--------------==$error");
//     });
//   }
//
//   Future<void> createChatRoomCollection(String orderId) async {
//     print('-------------createChatRoomCollection----------------');
//     Map<String, dynamic> paramMap = {
//       'created_at': DateTime.now().microsecondsSinceEpoch,
//       'order_id': orderId,
//     };
//     FirebaseFirestore.instance
//         .collection(_chatRoomCollection)
//         .doc(orderId)
//         .set(paramMap)
//         .then((_) {
//       print("-------------collection created-------------");
//     }).catchError((error) {
//       print("--------------an error occurred--------------==$error");
//     });
//   }
//
//   Future<void> createCartSubCollection(String? orderId, String? cartId,bool isSP) async {
//     print('-------------_bookingCartSubCollection----------------');
//     String userId='';
//     if(isSP)
//     {
//       ServiceProviderDetailsModel? serviceProviderDetailsModel =  getIt
//           .get<SharedPreferencesService>()
//           .getServiceProviderData(LocalStorageConstant.serviceProviderDataKey);
//       userId=serviceProviderDetailsModel?.id.toString()??"";
//     }
//     else
//     {
//
//       UserDataModel? userDataModel =  getIt
//           .get<SharedPreferencesService>()
//           .getUserData(LocalStorageConstant.userDataKey);
//       userId=userDataModel?.id.toString()??"";
//
//     }
//     Map<String, dynamic> paramMap = {
//       'created_at': DateTime.now().microsecondsSinceEpoch,
//       'user_id': userId,
//       'order_id': orderId,
//       'cart_id': cartId,
//       "platform": Platform.isIOS ? "IOS" : "Android",
//       'time': DateTime.now().toUtc(),
//     };
//     FirebaseFirestore.instance
//         .collection(_chatRoomCollection)
//         .doc(orderId)
//         .collection(_bookingCartSubCollection)
//         .doc(cartId)
//         .set(paramMap)
//         .then((_) {
//       print("-------------collection created-------------");
//     }).catchError((error) {
//       print("--------------an error occurred--------------==$error");
//     });
//   }
//
//   Future<void> createMessagesSubCollection(
//       String? orderId, String? cartID, String? msg, String? type,bool isSP) async {
//     print('-------------createChatRoomCollection----------------');
//     String userId='';
//     if(isSP)
//       {
//         ServiceProviderDetailsModel? serviceProviderDetailsModel =  getIt
//             .get<SharedPreferencesService>()
//             .getServiceProviderData(LocalStorageConstant.serviceProviderDataKey);
//         userId=serviceProviderDetailsModel?.id.toString()??"";
//       }
//    else
//      {
//
//        UserDataModel? userDataModel =  getIt
//            .get<SharedPreferencesService>()
//            .getUserData(LocalStorageConstant.userDataKey);
//        userId=userDataModel?.id.toString()??"";
//
//      }
//     Map<String, dynamic> paramMap = {
//       'created_at': DateTime.now().microsecondsSinceEpoch,
//       'user_id': userId,
//       'order_id': orderId,
//       'cart_id': cartID,
//       'msg_type': type,
//       "platform": Platform.isIOS ? "IOS" : "Android",
//       'msg_body': msg,
//       'time': DateTime.now().toUtc(),
//     };
//     FirebaseFirestore.instance
//         .collection(_chatRoomCollection)
//         .doc(orderId)
//         .collection(_bookingCartSubCollection)
//         .doc(cartID)
//         .collection(_messagesSubCollection)
//         .doc()
//         .set(paramMap)
//         .then((_) {
//       print("-------------collection created-------------");
//     }).catchError((error) {
//       print("--------------an error occurred--------------==$error");
//     });
//   }
//
//   Future<void> deleteCollection(String orderId) async {
//     print('-------------createChatRoomCollection----------------');
//     FirebaseFirestore.instance
//         .collection(_chatRoomCollection)
//         .doc(orderId)
//         .collection(_messagesSubCollection)
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         print('----------forEach---doc----------------${doc.id}');
//         doc.reference.delete();
//       });
//     });
//   }
//
//   Future<void> deleteMsgsCollection(String orderId) async {
//     print('-------------deleteMsgsCollection----------------');
//     FirebaseFirestore.instance
//         .collection(_chatRoomCollection)
//         .doc(orderId)
//         .delete()
//         .then((value) {
//       print('-------------delete----------------');
//     });
//   }
//
//   Future<void> sendFCMNotification(
//     String token,
//     String message,
//     String cartId,
//     String orderId,
//     String runnerId,
//     String userId,
//     String userFullName,
//     String runnerFullName,
//   ) async {
//     var serverKey =
// BrandVersionSingleton.instance.brandDetails?.serverKey
// AppConstant.fcmServerKey;
//  print("token ${token}");
//     try {
//       String storeName = 'App ${userFullName}';
//       http.Response response = await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization': 'key=$serverKey',
//         },
//         body: jsonEncode(
//           <String, dynamic>{
//             'notification': <String, dynamic>{
//               'body': message,
//               'title': storeName,
//             },
//             'priority': 'high',
//             'data': <String, dynamic>{
//               'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//               'id': '1',
//               'status': 'done',
//               'type': 'chat',
//               "orderId": orderId,
//               "cartId": cartId,
//               "runnerId": runnerId,
//               "userId": userId,
//               "userFullName": userFullName,
//               "runnerFullName": runnerFullName,
//             },
//             "click_action": "FLUTTER_NOTIFICATION_CLICK",
//             'to': token,
//           },
//         ),
//       );
//       print("send push notification");
//       print(response.body);
//       print(response.statusCode);
//     } catch (e) {
//       print("error push notification");
//     }
//   }
//
//   Future<void> sendInternetNotification(
//     String token,
//     String message,
//   ) async {
//     var serverKey = BrandVersionSingleton.instance.brandDetails!.serverKey;
//     try {
//       String storeName = 'App';
//       http.Response response = await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization': 'key=$serverKey',
//         },
//         body: jsonEncode(
//           <String, dynamic>{
//             'notification': <String, dynamic>{
//               'body': message,
//               'title': storeName,
//             },
//             'priority': 'high',
//             'to': token,
//           },
//         ),
//       );
//       print("send push notification");
//       print(response.body);
//       print(response.statusCode);
//     } catch (e) {
//       print("error push notification");
//     }
//   }
// }
