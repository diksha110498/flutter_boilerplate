

abstract class AuthenticationState {
  AuthenticationState();
}


class LoginState extends AuthenticationState {
  bool isSuccess;
  bool isDisabled;
  String message;

  LoginState(this.isSuccess, this.message,{this.isDisabled=false});
}
class SocialLoginState extends AuthenticationState {
  bool isSuccess;
  bool isExists;
  String email;
  String message;

  SocialLoginState(this.isSuccess, this.message,this.isExists,this.email);
}

