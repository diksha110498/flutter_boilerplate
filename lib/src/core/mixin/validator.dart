import '../app_utils/export.dart';

mixin Validator {
  ///change validation according to requirements. This is just for reference
  // Email validation
  bool validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return false;
    }
    return true;
  }

  bool validateReferralCode(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return true;
  }

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 4) {
      return "Password must be 4 characters";
    }
    return null;
  }

  // Confirm password validation
  String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return "Confirm password is required";
    } else if (value != password) {
      return "Confirm password does not match";
    }
    return null;
  }

  // Name validation
  bool validateName(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    } else if (value.length < 3 || value.length > 50) {
      return false;
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9]').hasMatch(value)) {
      return false;
    }
    return true;
  }

  bool validateCommonFields(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    } else if (value.length < 1) {
      return false;
    }
    return true;
  }

  bool validateOtp(String otp) {
    if (otp.trim().isEmpty) {
      return false;
    }
    if (otp.trim().length < 4) {
      return false;
    }
    return true;
  }

  bool validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return true;
  }

  bool validatePhone(String value) {
    if (value.trim().isEmpty) {
      EasyLoading.showToast(AppStrings.pleaseEnterPhoneNumber);
      return false;
    }
    if (AppUtils.extractPhoneNumber(value).length < 10) {
      EasyLoading.showToast(AppStrings.pleaseEnterValidPhoneNumber);
      return false;
    }
    return true;
  }
}
