import 'dart:async';
import 'dart:io';

import 'package:flashcards_quiz/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:widget_state_notifier/widget_state_notifier.dart';

import '../custom_textfield.dart';
import '../main.dart';
import '../services/auth_services.dart';
import 'home_screen.dart';
import 'login_screen.dart';
// Import the file where CustomTextField is defined

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  // final AuthService authService = AuthService();

  WidgetStateNotifier<bool> sessionNotifier =
      WidgetStateNotifier(currentValue: false);
  WidgetStateNotifier<bool> emailNotifier =
      WidgetStateNotifier(currentValue: false);
  WidgetStateNotifier<bool> passwordNotifier =
      WidgetStateNotifier(currentValue: false);
  WidgetStateNotifier<bool> studentIdNotifier =
      WidgetStateNotifier(currentValue: false);

  @override
  void initState() {
    super.initState();

    emailNotifier.addController(emailController, (stateNotifier) {
      stateNotifier.sendNewState(emailController.text.isNotEmpty);
    });
    passwordNotifier.addController(passwordController, (stateNotifier) {
      stateNotifier.sendNewState(passwordController.text.isNotEmpty);
    });
    studentIdNotifier.addController(studentIdController, (stateNotifier) {
      stateNotifier.sendNewState(studentIdController.text.isNotEmpty);
    });

    navigateToHome().then((value) {
      if (value) {
        sessionNotifier.sendNewState(value);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    emailNotifier.removeController(disposeMethod: () {
      emailController.dispose();
    });
    passwordNotifier.removeController(disposeMethod: () {
      passwordController.dispose();
    });
    studentIdNotifier.removeController(disposeMethod: () {
      studentIdController.dispose();
    });
  }

  // void signupUser() {
  //   authService.signUpUser(
  //     context: context,
  //     email: emailController.text,
  //     password: passwordController.text,
  //     studentId: studentIdController.text,
  //   );
  // }

  Stream<AuthResponse> signUpWithEmail(String email, String password,
      {Map<String, dynamic>? data}) {
    return SupabaseConfig.client.auth
        .signUp(email: email, password: password, data: data)
        .timeout(const Duration(seconds: 60))
        .asStream();
  }

  void onUnsuccessful(Object error) {
    closeCustomProgressBar(context);
    if (error.runtimeType == AuthException) {
      var errorCode = (error as AuthException).message;
      showSnackBar(context, errorCode);
    } else if (error.runtimeType == TimeoutException) {
      showSnackBar(context,
          "You were timeout under 1 minutes due to something that occurred.");
    } else {
      showSnackBar(context, "No internet connection");
    }
  }

  void onSignUpComplete(AuthResponse response) {
    if (response.user != null && response.session != null) {
      closeCustomProgressBar(context);

      UserDB()
          .insertUserRecordBothOnlineAndLocal(response.user?.id ?? '',
              studentIdController.text.trim(), emailController.text.trim())
          .then((value) {
        closeCustomProgressBar(context);
        emailController.clear();
        passwordController.clear();
        studentIdController.clear();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
        );
      }).onError((error, stackTrace) {
        closeCustomProgressBar(context);
        showSnackBar(context, "You will have to sign in");
        SupabaseConfig.client.auth.signOut();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
        );
      });
    } else {
      closeCustomProgressBar(context);
      showSnackBar(context, "Accounts exists. Sign in instead.");
    }
  }

  void signupUser() async {
    var isEmail = emailController.text.contains("@");
    var passwordMatch =
        passwordController.text.trim() == passwordController.text.trim();

    // Making sure it is an email
    showCustomProgressBar(context);
    if (isEmail && passwordMatch) {
      var email = emailController.text.trim();
      var password = passwordController.text.trim();

      signUpWithEmail(email, password).listen((event) {
        onSignUpComplete(event);
      }, onError: onUnsuccessful);
    } else if (!passwordMatch && isEmail) {
      // Display Password Match Problem
      closeCustomProgressBar(context);
      showSnackBar(context, "Passwords don't match");
    } else if (!isEmail && passwordMatch) {
      //  Display UnRecognized Email
      closeCustomProgressBar(context);
      showSnackBar(context, "You have entered a wrong email format");
    } else {
      closeCustomProgressBar(context);
      showSnackBar(context, "Please check your details.");
    }
  }

  Future<bool> navigateToHome() async {
    // Check current user
    Session? initialSession = await SupabaseConfig.client.auth.currentSession;

    dynamic userData = HiveConfig().getBox(userBoxName).get('record');

    if (initialSession?.user != null) {
      if (userData == null) {
        SupabaseConfig.client.auth.signOut();
        return true;
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetStateConsumer(
          widgetStateNotifier: sessionNotifier,
          widgetStateBuilder: (context, data) {
            if (data == false) {
              return Center(
                child: Platform.isIOS
                    ? Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8)),
                        child: const CupertinoActivityIndicator(
                          color: Colors.white,
                          radius: 35 / 2,
                        ))
                    : const CircularProgressIndicator(
                        color: bgColor3,
                      ),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Signup",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    controller: studentIdController,
                    hintText: 'Enter your StudentId',
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    controller: emailController,
                    hintText: 'Enter your email',
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    controller: passwordController,
                    hintText: 'Enter your password',
                  ),
                ),
                const SizedBox(height: 40),
                MultiWidgetStateConsumer(
                    widgetStateListNotifiers: [
                      emailNotifier,
                      passwordNotifier,
                      studentIdNotifier
                    ],
                    widgetStateListBuilder: (context) {
                      return ElevatedButton(
                        onPressed: () {
                          if (emailNotifier.currentValue == true &&
                              passwordNotifier.currentValue == true &&
                              studentIdNotifier.currentValue == true) {
                            signupUser();
                          } else {
                            showSnackBar(
                                context, "Enter values for all fields");
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(color: Colors.white),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width / 2.5, 50),
                          ),
                        ),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      );
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text('Login User?'),
                ),
              ],
            );
          }),
    );
  }
}
