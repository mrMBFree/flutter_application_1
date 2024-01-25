import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/users.dart';
import '../../db/database_users.dart';

bool isValidEmail(String email) {
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegExp.hasMatch(email);
}

bool isValidPassword(String password) {
  return password.length >= 8;
}

void registerValidation(BuildContext context, String username, String email,
    String password, String confirmPassword) async {
  if (_areFormFieldsNotEmpty(username, email, password, confirmPassword)) {
    bool userExists = await UsersDatabase.instance.doesUserExist(email);

    if (!userExists) {
      if (isValidEmail(email)) {
        if (isValidPassword(password)) {
          if (password == confirmPassword) {
            final user = User(
              username: username,
              email: email,
              password: password,
            );

            await UsersDatabase.instance.createUser(user);

            Navigator.pushReplacementNamed(context, '/home');
          } else {
            _showPasswordsMismatchDialog(context);
          }
        } else {
          _showInvalidPasswordDialog(context);
        }
      } else {
        _showInvalidEmailDialog(context);
      }
    } else {
      _showUserExistsDialog(context);
    }
  } else {
    _showEmptyFieldsDialog(context);
  }
}

bool _areFormFieldsNotEmpty(
    String username, String email, String password, String confirmPassword) {
  return username.isNotEmpty &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;
}

void _showEmptyFieldsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Empty Fields'),
        content: const Text('Please fill in all the required fields.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showUserExistsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('User Exists'),
        content: const Text('User with this email already exists.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showInvalidEmailDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Invalid Email'),
        content: const Text('Please enter a valid email address.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showPasswordsMismatchDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Passwords Mismatch'),
        content: const Text('The entered passwords do not match.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showInvalidPasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Invalid Password'),
        content:
            const Text('Please enter a password with at least 8 characters.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
