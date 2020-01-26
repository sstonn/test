class LoginRepo {
  Future<bool> login(String email, String password) async {
    try {
      if (email.compareTo('demo@mcom.app') == 0 &&
          password.compareTo('12345678') == 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
