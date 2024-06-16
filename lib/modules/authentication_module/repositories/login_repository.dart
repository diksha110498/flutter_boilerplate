import 'dart:convert';
import 'package:flutter_boilerplate/modules/authentication_module/models/success_response_model.dart';
import 'package:flutter_boilerplate/src/core/app_utils/local_storage_constant.dart';
import 'package:flutter_boilerplate/src/core/environments/environment.dart';
import 'package:flutter_boilerplate/src/core/network/dio_base_service.dart';

class LoginRepository extends DioBaseService {
  LoginRepository._()
      : super(Environment().config.apiHost + Environment().config.path);
  static LoginRepository? _instance;

  static LoginRepository get instance => _instance ??= LoginRepository._();

  final String _loginCustomerEndPoint = 'auth/customer-login';

  final String _mobileVerificationSocialEndPoint =
      'auth/mobile-verification-social';



    Future<SuccessResponseModel> loginApiCall(countrycode, mobileNumber) async {
      try {
        Map<String, dynamic> data = new Map<String, dynamic>();
        data['country_code'] = countrycode;
        data['phone'] = mobileNumber;
        final response = await postJson(
            _loginCustomerEndPoint,
            data);
        return SuccessResponseModel.fromJson(jsonDecode(response));
      } catch (e) {
        print('login excepton $e');
        return Future.error(e);
      }
    }



  }

