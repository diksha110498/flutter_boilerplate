import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_boilerplate/modules/authentication_module/bloc/login_bloc.dart';
import 'package:flutter_boilerplate/modules/authentication_module/bloc/state.dart';
import 'package:flutter_boilerplate/src/core/app_utils/app_utils.dart';
import 'package:flutter_boilerplate/src/core/app_utils/route_generators.dart';
import 'package:flutter_boilerplate/src/core/common_widget.dart';
import '../../../src/core/app_utils/export.dart';
import '../../../src/core/app_utils/local_storage_constant.dart';
import '../utils/common_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with Validator, CommonWidgetScreen {
  TextEditingController mobileEditingController = TextEditingController();
  FocusNode? mobileFocusNode;
  List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  GoogleSignIn? _googleSignIn;

  @override
  void initState() {
    mobileFocusNode = FocusNode();
    _googleSignIn = GoogleSignIn(
      scopes: scopes,
    );
    _getFcmToken();
    super.initState();
  }

  _getFcmToken() {
    FirebaseMessaging.instance.getToken().then((value) {
      getIt
          .get<SharedPreferencesService>()
          .setString(LocalStorageConstant.fcmTokenKey, value ?? '');
    }, onError: (e) {
      print("Unable to get token");
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) async {
        if (value) {
          return;
        }

            NavigationService.goBack();

      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: buildBody(
            context,
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        CommonRegistrationHeader(),
        SizedBox(height: AppSizes.largevGapSize),
        Text(AppStrings.enterYourMobileNumberString,
            style: AppFontStyle.getSubHeadingStyle()),
        SizedBox(height: AppSizes.largevGapSize),
        _textField(),
        SizedBox(height: AppSizes.smallhGapSize),
        _yourAreNotRegistered(),
        SizedBox(height: AppSizes.largevGapSize),
        _loginButton(context),
        SizedBox(height: AppSizes.largevGapSize),
        _newToApp(),
        SizedBox(height: AppSizes.smallvGapSize),
        Column(children: [
          _or(),
          SizedBox(height: AppSizes.smallvGapSize),
          _socialLogins()
        ]),
        SizedBox(height: AppSizes.smallvGapSize),
      ],
    );
  }

  _textField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.largePadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppConstant.countryCodeKey,
                  style: AppFontStyle.getContentSmallTextStyle(
                      color: AppColors.inputTextColor)),
              SizedBox(height: AppSizes.smallvGapSize),
              SizedBox(
                  width: AppSizes.extraLargehGapSize,
                  child: Divider(
                    color: AppColors.textFieldBorderColor,
                  ),
                  height: 0.0)
            ],
          ),
          SizedBox(width: AppSizes.smallhGapSize),
          Expanded(
              child: CustomTextField(
            mobileEditingController,
            mobileFocusNode,
            AppStrings.enterYourMobileNumberString,
            textInputType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            inputFormatter: [
              MaskTextInputFormatter(
                  mask: '(###) ### - ####',
                  filter: {"#": RegExp(r'[0-9]')},
                  type: MaskAutoCompletionType.lazy)
            ],
          )),
        ],
      ),
    );
  }

  _yourAreNotRegistered() {
    return BlocConsumer<LoginBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginState) {
          if (state.isDisabled) {
            DialogUtils.commonDialog(
                context,
                AlertDialog(
                  elevation: 0.0,
                  contentPadding: EdgeInsets.all(AppSizes.largePadding),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSizes.defaultRoundedRadius)),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            NavigationService.goBack();
                          },
                          child: Icon(Icons.close,
                              color: AppColors.inputTextColor),
                        ),
                      ),
                      SizedBox(height: AppSizes.mediumvGapSize),
                      Text("Account Disabled",
                          style: AppFontStyle.getSubHeadingStyle()),
                      SizedBox(height: AppSizes.mediumvGapSize),
                      Text(
                          "Your account has been disabled by administrator. Please contact support for assistance.",
                          textAlign: TextAlign.center,
                          style: AppFontStyle.getContentMediumTextStyle()),
                      SizedBox(height: AppSizes.mediumvGapSize),
                    ],
                  ),
                ));
          }
        }
      },
      builder: (context, state) {
        if (state is LoginState) {
          return Visibility(
            visible: !state.isSuccess && state.message.isNotEmpty,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.largePadding),
              child: Text(state.message ?? '',
                  style: AppFontStyle.getContentExtraSmallTextStyle(
                      color: AppColors.redColor)),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  _loginButton(context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.largePadding),
        child: CustomButton(AppStrings.loginString, () {
          if (!validatePhone(mobileEditingController.text.trim())) {
            return;
          }
          BlocProvider.of<LoginBloc>(context).loginApiCall(
              AppConstant.countryCodeKey.toString().replaceAll('+', ''),
              AppUtils.extractPhoneNumber(mobileEditingController.text.trim()));
        }, AppColors.buttonColor));
  }

  _newToApp() {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: AppStrings.newToAppString,
          style: AppFontStyle.getContentMediumTextStyle()),
      TextSpan(
          text: AppStrings.signUpString,
          recognizer: TapGestureRecognizer()
            ..onTap =
                () => NavigationService.navigateTo(RoutesGenerator.signUpRoute),
          style:
              AppFontStyle.getSubHeadingStyle(color: AppColors.linkTextColor)),
    ]));
  }

  _or() {
    return Text(AppStrings.orString,
        style: AppFontStyle.getContentMediumTextStyle());
  }

  _socialLogins() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialLoginButtonView(
            AppImages.googleIcon, AppStrings.continueWithGoogleString, () {
          BlocProvider.of<LoginBloc>(context)
              .performGoogleSignin(_googleSignIn!);
        }),
        SizedBox(height: AppSizes.mediumvGapSize),
        Visibility(
          visible: Platform.isIOS,
          child: _socialLoginButtonView(
              AppImages.appleIcon, AppStrings.continueWithAppleString, () {
            BlocProvider.of<LoginBloc>(context).performAppleSignin();
          }),
        ),
        Visibility(
            visible: Platform.isIOS,
            child: SizedBox(height: AppSizes.mediumvGapSize)),
        _socialLoginButtonView(AppImages.facebookIcon,
            AppStrings.continueWithFacebookString, () {}),
      ],
    );
  }

  _socialLoginButtonView(imageName, buttonText, OnTap) {
    return InkWell(
      onTap: () {
        OnTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppSizes.xxLPadding),
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.largePadding,
            vertical: AppSizes.mediumPadding),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.largeRoundedRadius),
            border: Border.all(color: AppColors.textFieldBorderColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imageName,
                width: AppSizes.largeIconSize,
                height: AppSizes.largeIconWidthSize),
            SizedBox(width: AppSizes.smallhGapSize),
            Text(buttonText, style: AppFontStyle.getContentLargeTextStyle())
          ],
        ),
      ),
    );
  }


}
