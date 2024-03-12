import 'dart:async';

import 'package:flashcards_quiz/utils/utils.dart';
import 'package:flashcards_quiz/views/home_screen.dart';
import 'package:flashcards_quiz/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:widget_state_notifier/widget_state_notifier.dart';

import '../custom_textfield.dart';
import '../main.dart';
import '../services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  WidgetStateNotifier<bool> emailNotifier = WidgetStateNotifier(currentValue: false);
  WidgetStateNotifier<bool> passwordNotifier = WidgetStateNotifier(currentValue: false);
  // final AuthService authService = AuthService();

  // void loginUser() {
  //   authService.signInUser(
  //     context: context,
  //     email: emailController.text,
  //     password: passwordController.text,
  //   );
  // }

  @override
  void initState() {
    super.initState();

    emailNotifier.addController(emailController, (stateNotifier) {
      stateNotifier.sendNewState(emailController.text.isNotEmpty);
    });

    passwordNotifier.addController(passwordController, (stateNotifier) {
      stateNotifier.sendNewState(passwordController.text.isNotEmpty);
    });

  }


  void onUnsuccessful(Object error) {
    closeCustomProgressBar(context);
    if (error.runtimeType == AuthException) {
      String errorMessage =
      (error as AuthException).message.toLowerCase();

      switch (errorMessage) {
        case "email not confirmed":
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => VerificationPage(
          //           email: userNameController.text.trim(),
          //           otpType: OtpType.signup,
          //         )));
          break;

        default:
          showSnackBar(context, errorMessage);
      }
    } else if (error.runtimeType == TimeoutException) {
      showSnackBar(context,
          "You were timeout under 1 minute due to something that occurred.");
    } else {
      showDebug(msg: "$error");

      showSnackBar(context, "No internet connection.");
    }
  }

  void proceedToInformationPage(String uuid) {
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => InformationPage(uuid: uuid)),
    //       (Route<dynamic> route) => false,
    // );
  }

  void goToSecondaryPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false,
    );
  }

  Future<dynamic> userOnlineRecord(String? userId) async {
    if (userId == null) return null;
    return await SupabaseConfig.client
        .from("user_table")
        .select()
        .eq("id", userId)
        .maybeSingle();
  }

  void onSignInComplete(AuthResponse response) async {
    String? uuid = response.user?.id;

    showCustomProgressBar(context);
    // Check online record and update to local database
    userOnlineRecord(SupabaseConfig.client.auth.currentUser?.id ?? '')
        .then((userData) {
      // User data not null
      if (userData != null) {
        // Retrieve the uuid
        // Check if there is a value
        if (uuid != null) {
                // Save the user data to storage
          UserDB().saveOnlineUserRecordToLocal(userData, useOther: true)
                    .then((saved) {
                  //  Check if saving operation was success
                  if (saved) {
                        closeCustomProgressBar(context);
                        goToSecondaryPage();

                  } else {
                    // Unable to save data
                    onSignInError(3);
                  }
                }).onError((error, stackTrace) => onSignInError(4));


        } else {
          // Retrieving uuid failed
          onSignInError(9);
        }
      } else if (uuid != null) {
        // User data is null
        proceedToInformationPage(uuid);
      } else {
        // Retrieving uuid failed
        onSignInError(16);
      }
    }).onError((error, stackTrace) {
      onSignInError(17);
    });
  }

  Future<Null>? onSignInError(int n) async {
    closeCustomProgressBar(context);
    showSnackBar(context, "Unable to Sign in at the moment. Code $n");
    SupabaseConfig.client.auth.signOut().then((value){
      Navigator.pop(context);
    });
  }


  Stream<AuthResponse> loginUser() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    return SupabaseConfig.client.auth
        .signInWithPassword(email: email, password: password)
        .timeout(const Duration(seconds: 60))
        .asStream();
  }

  void signInUsers() {
    showCustomProgressBar(context, cancelTouch: true);

    var isEmail = emailController.text.contains("@");

    if (isEmail) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      loginUser().listen(
              (event) {
            closeCustomProgressBar(context);
            if (event.user != null) {
              onSignInComplete(event);
            } else {
              showSnackBar(context, "Try again!!!");
            }
          }, onError: onUnsuccessful);
    } else {
      showSnackBar(context, "Check your email address or username.");
      closeCustomProgressBar(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
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
            widgetStateListNotifiers: [emailNotifier,passwordNotifier],
            widgetStateListBuilder: (context) {
              return ElevatedButton(
                onPressed: (){
                  if(emailNotifier.currentValue == true && passwordNotifier.currentValue == true){
                    signInUsers();
                  }else{
                    showSnackBar(context, "Enter values for all fields");
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.white),
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width / 2.5, 50),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignupScreen(),
                ),
              );
            },
            child: const Text('Sign Up User?'),
          ),
        ],
      ),
    );
  }
}
