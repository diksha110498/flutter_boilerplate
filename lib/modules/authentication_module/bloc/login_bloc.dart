import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_boilerplate/modules/authentication_module/bloc/state.dart';
import 'package:flutter_boilerplate/src/core/network/api_exception.dart';
import '../../../src/core/app_utils/export.dart';
import '../../../src/core/app_utils/local_storage_constant.dart';
import '../repositories/login_repository.dart';

class LoginBloc extends Cubit<AuthenticationState> {
  LoginBloc() : super(LoginState(false, ''));


  Future<void> performGoogleSignin(GoogleSignIn googleSignIn) async {
    EasyLoading.show();
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount?.email != null &&
          googleSignInAccount!.email.isNotEmpty) {

          EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
      }
    } catch (error) {
      EasyLoading.dismiss();
      EasyLoading.showToast(error.toString());
      emit(SocialLoginState(false, "", false, ''));
    }
  }
  Future<void> performAppleSignin( ) async {
    EasyLoading.show();
    try {
      AuthorizationCredentialAppleID? authorizationCredentialAppleID = await SignInWithApple.getAppleIDCredential( scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],);
      if (authorizationCredentialAppleID.userIdentifier != null &&
          authorizationCredentialAppleID.userIdentifier!.isNotEmpty) {

          EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
      }
    } catch (error) {
      EasyLoading.dismiss();
      EasyLoading.showToast(error.toString());
      emit(SocialLoginState(false, "", false, ''));
    }
  }

  void loginApiCall(countrycode, mobileNumber) {
    EasyLoading.show();
    LoginRepository.instance
        .loginApiCall(countrycode, mobileNumber)
        .then((value) {
      emit(LoginState(true, value.message ?? ""));
      var arguments = {
        AppConstant.countryKey:
            AppConstant.countryCodeKey.toString().replaceAll('+', ''),
        AppConstant.phoneNumberKey: mobileNumber,
        AppConstant.isFromLoginKey: true,
      };
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      //for custom exceptio
      if (error is CustomNotFoundException) {
        if (error.data != null) {
          emit(LoginState(false, error.message ?? "", isDisabled: true));
        } else {
          EasyLoading.showToast(error.message ?? "");
          emit(LoginState(false, error.message ?? ""));
        }
      } else {
        EasyLoading.showToast(error.toString());
        emit(LoginState(false, error.toString()));
      }
    });
  }

}
