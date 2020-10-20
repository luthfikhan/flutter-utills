class Validator {
  static bool isValidEmail(String email) {
    final regExp = RegExp("^[\\w-_.]*[\\w-_.]@([\\w]+\\.)+[\\w]+[\\w]\$");

    return regExp.hasMatch(email);
  }

  static bool isValidPhoneNumber(String number) {
    return number.length >= 10 && number.length <= 13;
  }
}
