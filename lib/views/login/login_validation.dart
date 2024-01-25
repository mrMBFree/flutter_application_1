import 'package:flutter_application_1/db/database_users.dart';

class LoginValidation {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  static Future<bool> validateLogin(String email, String password) async {
    // Pobierz użytkownika z bazy danych na podstawie podanego emaila
    final user = await UsersDatabase.instance.readUserByEmail(email);

    // Sprawdź, czy użytkownik o podanym emailu istnieje i czy hasło się zgadza
    return user != null && user.password == password;
  }
}
