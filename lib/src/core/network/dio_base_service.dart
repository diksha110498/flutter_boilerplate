import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/src/core/app_utils/local_storage_constant.dart';
import 'package:flutter_boilerplate/src/core/connectivity/network_connection_observer.dart';
import 'package:flutter_boilerplate/src/core/di/service_locator.dart';
import 'package:flutter_boilerplate/src/core/local_storage/shared_preferences.dart';
import 'package:flutter_boilerplate/src/core/models/error_response.dart';
import 'package:flutter_boilerplate/common_model/error_response_model.dart';
import 'package:flutter_boilerplate/src/core/network/refresh_token_interceptor.dart';
import 'api_exception.dart';
import 'dart:async';
import 'package:firebase_performance/firebase_performance.dart';

typedef UploadProgressCallback = void Function(double progress);

abstract class DioBaseService {
  CancelToken _cancelToken = CancelToken();
  late Dio _dioClient;
  late String _baseUrl;

  final NetworkConnectionObserver network =
      getIt.get<NetworkConnectionObserver>();

  DioBaseService(String baseUrl) {
    this._baseUrl = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    _createClient();
  }

  @protected
  Map<String, dynamic> getHeader() {
    final SharedPreferencesService sharedPrefs =
        getIt.get<SharedPreferencesService>();
    return {
      "Content-Type": "application/json",
      "Authorization":
          "Bearer ${sharedPrefs.getString(LocalStorageConstant.authTokenKey, defaultValue: '')}" ??
              "",
    };
  }

  void _createClient() {
    _dioClient = Dio();
    _dioClient.options
      ..baseUrl = _baseUrl
      ..connectTimeout = const Duration(seconds: 10)
      ..sendTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10)
      ..headers = getHeader()
      ..responseType = ResponseType.plain;
    _dioClient.interceptors.add(RefreshTokenInterceptor(_dioClient));
    _dioClient.interceptors.add(LogInterceptor(
        requestBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
        responseBody: true,
        request: false));
  }

  @protected
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      if (network.offline) {
        throw ConnectionException("Internet Not Available");
      }
      final HttpMetric metric =
          FirebasePerformance.instance.newHttpMetric(path, HttpMethod.Get);
      await metric.start();
      Response response = await _dioClient.get(path,
          queryParameters: queryParams,
          options: Options(headers: getHeader()),
          cancelToken: _cancelToken);
      metric.httpResponseCode = response.statusCode;
      await metric.stop();

      return _responseHandler(response);
    } on DioException catch (dioError) {
      _errorHandler(dioError);
    }
  }

  @protected
  Future<dynamic> post(
    String path,
    Map<String, dynamic> data,
      {newData}) async {
    try {
      if (network.offline) {
        throw ConnectionException("Internet Not Available");
      }
      final HttpMetric metric =
          FirebasePerformance.instance.newHttpMetric(path, HttpMethod.Post);
      await metric.start();

      Response response = await _dioClient.post(path,
          data:newData?? FormData.fromMap(data),
          options: Options(headers: getHeader()),
          cancelToken: _cancelToken);
      metric.httpResponseCode = response.statusCode;
      await metric.stop();
      return _responseHandler(response);
    } on DioException catch (dioError) {
      _errorHandler(dioError);
    } catch (e, stackTrace) {
      print("e ${e} stackTrace${stackTrace}");
      return Future.error(e);
    }
  }

  Future<dynamic> uploadImage(String path, File imageFile,
      UploadProgressCallback progressCallback) async {
    try {
      if (network.offline) {
        throw ConnectionException("Internet Not Available");
      }
      final HttpMetric metric =
          FirebasePerformance.instance.newHttpMetric(path, HttpMethod.Post);
      await metric.start();
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      Response response = await _dioClient.post(path, data: formData,
          onSendProgress: (int sent, int total) {
        double progress = sent / total;
        progressCallback(progress);
        print("Upload Progress: ${progress.toStringAsFixed(2)}%");
      }, cancelToken: _cancelToken, options: Options(headers: getHeader()));
      metric.httpResponseCode = response.statusCode;
      await metric.stop();
      return _responseHandler(response);
    } on DioException catch (dioError) {
      _errorHandler(dioError);
    }
  }

  @protected
  Future<dynamic> postJson(
    String path,
    Map<String, dynamic> data,
  ) async {
    try {
      if (network.offline) {
        throw ConnectionException("Internet Not Available");
      }
      final HttpMetric metric =
          FirebasePerformance.instance.newHttpMetric(path, HttpMethod.Post);
      await metric.start();
      Response response = await _dioClient.post(path,
          data: jsonEncode(data),
          options: Options(headers: getHeader()),
          cancelToken: _cancelToken);
      metric.httpResponseCode = response.statusCode;
      await metric.stop();
      return _responseHandler(response);
    } on DioException catch (dioError) {
      _errorHandler(dioError);
    } catch (e, stackTrace) {
      print("post error ${e} stackTrace${stackTrace}");
      return Future.error(e);
    }
  }

  @protected
  Future<dynamic> put(
    String path,
    Map<String, dynamic> data,
  ) async {
    try {
      if (network.offline) {
        throw ConnectionException("Internet Not Available");
      }
      Response response = await _dioClient.put(path,
          data: data,
          options: Options(headers: getHeader()),
          cancelToken: _cancelToken);
      return _responseHandler(response);
    } on DioException catch (dioError) {
      _errorHandler(dioError);
    }
  }

  @protected
  Future<dynamic> delete(String path, {Map<String, dynamic>? data}) async {
    try {
      Response response = await _dioClient.delete(path,
          data: data,
          cancelToken: _cancelToken,
          options: Options(headers: getHeader()));
      return _responseHandler(response);
    } on DioException catch (dioError) {
      _errorHandler(dioError);
    }
  }

  void _errorHandler(DioException error) {
    print('----_errorHandler----$error');
    _errorStatus(error);
    print('----_errorHandler second----$error');

    DioExceptionType dioExceptionType = error.type;
    switch (dioExceptionType) {
      case DioExceptionType.connectionTimeout:
        throw ConnectionException('connection time out');
      case DioExceptionType.sendTimeout:
        throw ConnectionException('request time out');
      case DioExceptionType.receiveTimeout:
        throw ConnectionException('response time out');
      case DioExceptionType.badResponse:
        throw ConnectionException('bad Response');
      case DioExceptionType.badCertificate:
        //_errorStatus(error.response);
        throw ConnectionException('bad Certificate');
      //break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        if (error is SocketException) {
          throw FetchDataException('Socket');
        }
        throw FetchDataException('No internet connection');
      case DioExceptionType.connectionError:
        // TODO: Handle this case.
        throw ConnectionException('connection Error');
      default:
        throw FetchDataException(
            'Error occured while Communication with Server ${error}');
    }
  }

  dynamic _responseHandler(Response response) {
    //print('----f_responseHandler----f =${response}');
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 203:
        if (response.data == null || response.data.isEmpty) {
          throw EmptyResultApiException();
        }
        return response.data;
    }
  }

  void _errorStatus(DioException dioException) {
    ErrorResponseModel? errorResponseModel;
    if (dioException.response?.data != null) {
      errorResponseModel =
          ErrorResponseModel.fromJson(jsonDecode(dioException.response!.data));
    }

    switch (dioException.response?.statusCode) {
      case 400:
        throw BadRequestException(errorResponseModel?.message ?? "");
      case 401:
        final errorResponse =
            errorResponseFromJson(dioException.response?.data);
        throw BadResponseException(errorResponse);
      case 403:
        throw UnauthorisedException(dioException.response?.data?.toString());
      case 404:
        if (errorResponseModel?.data != null) {
          throw CustomNotFoundException(errorResponseModel?.message ?? "",
              data: errorResponseModel?.data);
        } else {
          throw NotFoundException(errorResponseModel?.message ?? "");
        }
      case 500:
      default:
        throw FetchDataException(dioException.response?.statusCode != null
            ? 'Error occured while Communication with Server with StatusCode : ${dioException.response?.statusCode ?? ''}'
            : 'Error occured while Communication with Server');
    }
  }
}
