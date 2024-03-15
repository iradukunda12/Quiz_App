import 'dart:convert';

import 'package:flashcards_quiz/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';
import '../providers/user_Provider.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';
import '../views/signup_screen.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String studentId,
  }) {
    try {
      User user = User(
        studentId: '',
        password: password,
        email: email,
        token: '',
      );

      http.post(
        Uri.parse('${Constants.uri}/api/register'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((http.Response res) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
              context,
              'Account created! Login with the same credentials!',
            );
          },
        );
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void sendMessage(BuildContext context, String message) {
    showSnackBar(
      context,
      message,
    );
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    try {
      var userProvider = Provider.of<Users>(context, listen: false);

      final navigator = Navigator.of(context);
      http.post(
        Uri.parse('${Constants.uri}/api/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((http.Response res) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            userProvider.setUser(User.fromJson(res.body));
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (route) => false,
            );
          },
        );
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData(
    BuildContext context,
  ) {
    try {
      var userProvider = Provider.of<Users>(context, listen: false);
      SharedPreferences.getInstance().then((SharedPreferences prefs) {
        String? token = prefs.getString('x-auth-token');

        if (token == null) {
          prefs.setString('x-auth-token', '');
        }

        http.post(
          Uri.parse('${Constants.uri}/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!,
          },
        ).then((tokenRes) {
          var response = jsonDecode(tokenRes.body);
          if (response == true) {
            http.get(
              Uri.parse('${Constants.uri}/'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': token
              },
            ).then((http.Response userRes) {
              userProvider.setUser(userRes.body as User);
            });
          }
        });
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
      (route) => false,
    );
  }
}
