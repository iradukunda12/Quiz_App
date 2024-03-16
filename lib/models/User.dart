import 'dart:convert';

class User {
  final String studentId;
  final String email;
  final String token;
  final String password;

  User({
    required this.studentId,
    required this.email,
    required this.token,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'email': email,
      'token': token,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      studentId: map['studentId'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
