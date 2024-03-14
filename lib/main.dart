import 'dart:io';

import 'package:flashcards_quiz/views/home_screen.dart';
import 'package:flashcards_quiz/views/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


bool isAdmin = false;
String adminEmail = 'admin@gmail.com';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();


  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );


    await SupabaseConfig.initialize;
    await HiveConfig().startHive();

    await HiveConfig().interface().openBox("userBox");

  runApp(MyApp());

}

bool closeCustomProgressBar(BuildContext context) {
  Navigator.pop(context);
  return false;
}

class SupabaseConfig {
  static final SupabaseConfig instance = SupabaseConfig.internal();

  factory SupabaseConfig() => instance;

  SupabaseConfig.internal();

  static String url = 'https://atxenegeuegtqbqjnlbl.supabase.co';
  static String apiKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF0eGVuZWdldWVndHFicWpubGJsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDk5ODEzNjQsImV4cCI6MjAyNTU1NzM2NH0.HztUBloaSeUXPVCG9Cj3vU7nRrlcNGxbrC9Snwkk640';
  static final initialize = Supabase.initialize(url: url, anonKey: apiKey);
  static final client = Supabase.instance.client;

}

class HiveConfig {
  static final HiveConfig instance = HiveConfig.internal();

  factory HiveConfig() => instance;

  HiveConfig.internal();

  HiveInterface interface() {
    return Hive;
  }

  Future<void> startHive() async {
    return await interface().initFlutter();
  }

  Box getBox(String boxName){
    return interface().box(boxName);
  }

}





const userBoxName = 'userBox';
const Color bgColor = Color(0xFF4993FA);
const Color bgColor3 = Color(0xFF5170FD);



BuildContext showCustomProgressBar(BuildContext context,
    {var cancelTouch = false}) {
  BuildContext usingContext = context;
  showDialog(
    context: context,
    builder: (usedContext) {
      usingContext = usedContext;
      return WillPopScope(
        onWillPop: () async {
          // Handle back button press here
          if (cancelTouch) {
            // If cancelTouch is true, allow the progress to be canceled
            // and dismiss the dialog
            Navigator.of(usedContext).pop();
            return true;
          } else {
            // If cancelTouch is false, prevent the progress from being canceled
            return false;
          }
        },
        child: Center(
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
        ),
      );
    },
    barrierDismissible: false, // Always set to false here
  );
  return usingContext;
}

showDebug({dynamic msg = ''}) {
  if (kDebugMode) {
    print(msg);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const SignupScreen(),
    );
  }
}


class UserDB{


  static Future<bool> updateTheValue(String column, dynamic value,
      {bool forceUpdate = false}) async {
    Box membersBox = HiveConfig().getBox(userBoxName);
    dynamic record = membersBox.get("record");
    if (record != null && record is Map<dynamic, dynamic>) {
      if (record[column] != value || forceUpdate) {
        record[column] = value;
        return membersBox
            .put("record", record)
            .then((value) => true)
            .onError((error, stackTrace) => false);
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> insertUserRecordBothOnlineAndLocal(
      String uuid,
      String studentId,
      String email) async {
    return await SupabaseConfig.client
        .from("user_table")
        .insert({
      "id": uuid,
      "studentId": studentId,
      "email": email,
    })
        .select()
        .maybeSingle()
        .then((userData) {
      if (userData != null) {
        saveOnlineUserRecordToLocal(userData);
      }
      return true;
    })
        .onError((error, stackTrace) {
      showDebug(msg: "$error $stackTrace");

      return false;
    });
  }



  Future<bool> saveOnlineUserRecordToLocal(dynamic data,
      {bool useOther = false}) async {
    Box userBox = HiveConfig().getBox(userBoxName);

    if (data == null && useOther) {
      return true;
    }

    return await userBox.put("record", {
      "id": data?["id"],
      "studentId": data?["studentId"],
      "email": data?["email"],
    }).then((value) {
      if (useOther) {
        return true;
      } else {
        return false;
      }
    }).onError((error, stackTrace) {
      showDebug(msg: "$error $stackTrace");
      return false;
    });
  }

  Future<bool> saveUserOtherRecordToLocal(
      String fieldName, dynamic value) async {
    Box userBox = HiveConfig().getBox(userBoxName);
    return await userBox.put(fieldName, value).then((value) => true);
  }

  dynamic getUserRecord({String? field}) {
    Box userBox = HiveConfig().getBox(userBoxName);
    final userRecord = userBox.get("record");
    return field != null ? (userRecord?[field]) : userRecord;
  }

  Future<bool> removeExistedUserRecord() async {
    Future clearUserBox = HiveConfig().getBox(userBoxName).clear();
    // Future clearSettingBox = SettingsOperation().clearEntries();
    // Future clearReferralBox = ReferralOperation().clearEntries();

    return Future.wait([
      clearUserBox,
      // clearSettingBox,clearReferralBox
    ]).then((value) {
      return value.every((element) => true);
    }).onError((error, stackTrace) => false);
  }

}
