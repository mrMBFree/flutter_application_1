// ignore: duplicate_ignore
// ignore: prefer_const_declarations
// ignore_for_file: prefer_const_declarations

final String tableUsers = 'users';

class UserFields {
  static final List<String> values = [id, username, email, password];

  static final String id = '_id';
  static final String username = 'username';
  static final String email = 'email';
  static final String password = 'password';
}

class User {
  final int? id;
  final String username;
  final String email;
  final String password;

  const User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  User copy({
    int? id,
    String? username,
    String? email,
    String? password,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  static User fromJson(Map<String, Object?> json) => User(
        id: json[UserFields.id] as int?,
        username: json[UserFields.username] as String,
        email: json[UserFields.email] as String,
        password: json[UserFields.password] as String,
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.username: username,
        UserFields.email: email,
        UserFields.password: password,
      };
}
