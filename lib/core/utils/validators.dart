class Validators {
  static final RegExp _stringRegExp = RegExp(
    r'^[a-zA-Z0-9.@!#$%&’*+/=?^_`{|}~-]{6,}$',
  );

  static isValidEmail(String email) {
    return _stringRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _stringRegExp.hasMatch(password);
  }
}
