import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../models/refresh_token_response_model.dart';
import 'package:flutter_boilerplate/src/core/environments/dev_config.dart';
import '../app_utils/export.dart';
import '../app_utils/local_storage_constant.dart';


class RefreshTokenInterceptor extends Interceptor {
  final Dio _dio;
  bool isRefreshing = false;

  RefreshTokenInterceptor(this._dio);

  String customerRefreshTokenEndPoint = "auth/refresh-customer-token";
  String serviceProviderRefreshTokenEndPoint =
      "auth/refresh-service-provider-token";

  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Add the access token to the request headers
    final SharedPreferencesService sharedPrefs =
        getIt.get<SharedPreferencesService>();
    options.headers['Authorization'] =
        'Bearer ${sharedPrefs.getString(LocalStorageConstant.authTokenKey)}';
    return super.onRequest(options, handler);
  }

  @override
  Future<dynamic> onError(
      DioException error, ErrorInterceptorHandler handler) async {
    // Check if the error is due to an expired access token
    if (error.response?.statusCode == 401) {
      // Refresh the access token
      if (isRefreshing == false && AppConstant.isLoggedIn == true) {
        final newAccessToken = await refreshAccessToken();
        // Retry the failed request with the new access token
        if (newAccessToken != null) {
          error.requestOptions.headers['Authorization'] =
              'Bearer ${newAccessToken ?? ""}';
          var response = await _dio.request<dynamic>(
            error.requestOptions.path,
            cancelToken: error.requestOptions.cancelToken,
            data: error.requestOptions.data,
            options: Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers,
            ),
          );
          return handler.resolve(response);
        }
      }
    }

    return super.onError(error, handler);
  }

  Future<String?> refreshAccessToken() async {
    isRefreshing = true;
    try {

     var   response = await _dio.get(DevConfig().apiHost +
            DevConfig().path +
            customerRefreshTokenEndPoint);

      if (response != null) {
        RefreshTokenResponseModel responseModel =
            RefreshTokenResponseModel.fromJson(jsonDecode(response?.data));
        if (responseModel.data != null) {
          final newAccessToken = responseModel.data?.accessToken;
          getIt.get<SharedPreferencesService>().setString(
              LocalStorageConstant.authTokenKey, newAccessToken ?? "");
          isRefreshing = false;
          return newAccessToken;
        }
      }
    } catch (e) {
      print("exception ${e}");
      _logoutUser();
      return Future.error(e);
    }
  }

  _logoutUser() async {
   }
}
