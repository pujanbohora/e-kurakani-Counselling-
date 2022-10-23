//this is used to validate input fields

// Package imports:

// Project imports:

typedef ValidatorFunc = String? Function(String?);

class Validators {
  static String? validateConfirmPassword(
      String password, String? value, bool canClear) {
    RegExp regExp =
        RegExp(r'((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).{8,64})');
    if (canClear) {
      return null;
    }
    if (password != value || value!.isEmpty) {
      return 'Passwords do not match';
    } else if (value.length < 8) {
      // return LocaleKeys.password_mustBeEightCharacters.tr();
    } else if (!regExp.hasMatch(value)) {
      // return LocaleKeys.password_mustContainLetterAndDigit.tr();
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) {
    RegExp regExp = RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    if (!regExp.hasMatch(value!)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validateFirstName(String? value, canClear) {
    if (value == null || value.length < 3) {
      return 'Enter a valid first name';
    }
    return null;
  }

  static String? validateAddCategoryName(String? value, canClear) {
    if (value == null) {
      return 'Enter a valid Category name';
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.length < 3) {
      return 'Enter a valid last name';
    }
    return null;
  }

  static String? validatePassword(String? value, bool canClear) {
    RegExp regExp =
        RegExp(r'((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).{8,64})');
    if (canClear) {
      return null;
    }
    if (value == null) {
      return null;
    }
    if (value.length < 8) {
      return 'Password must be greated that 8';
    }
    if (!regExp.hasMatch(value)) {
      // return LocaleKeys.password_mustContainLetterAndDigit.tr();
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? value) {
    RegExp regExp = RegExp(
        r'^(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?$');
    if (!regExp.hasMatch(value ?? "")) {
      return 'Invalid Phone Number';
    } else {
      return null;
    }
  }

  static String? validateZipCode(String? value) {
    if (value == null || value.length != 5) {
      return 'Enter a valid zipcode';
    }
    return null;
  }
}
