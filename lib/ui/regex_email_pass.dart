// @dart=2.9
class RegexEmailPass {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-zA-Z]+$',
  );
  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
  );

  static isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegex.hasMatch(password);
  }
}
