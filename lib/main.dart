import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Auth/sign_up.dart';

import 'core/constant/app_string.dart';
import 'core/constant/shared_pref.dart';
import 'core/firebase/firebase_get_doc_percent.dart';
import 'core/firebase/firebase_get_doc_sessions.dart';
import 'core/firebase/firebase_update_user_info.dart';
import 'exam/home.dart';
import 'exam/test_screen.dart';
import 'generated/l10n.dart';
import 'splash_screen.dart';

bool isLogIn = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:496648547516:android:4e44a03ba6b5b540c274b9',
      messagingSenderId: '496648547516',
      projectId: 'onlineexam-693a0',
      apiKey: 'AIzaSyBvKU1LoH36S2S1C2ozrEc_mhexNOd7v2w',
    ),
  );
  sharedPreferences = await SharedPreferences.getInstance();
  isLogIn = sharedPreferences!.getBool(AppString.isLogIn) ?? false;
  sharedPreferences!.setString(AppString.sessions,
      Timestamp.fromDate(DateTime.now()).seconds.toString());

  sharedPreferences!
      .setInt(AppString.precent, isLogIn ? await getDocPercent() : 0);
  sharedPreferences!.setInt(AppString.resumed, 0);
  //precent = await getDocPercent();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    List sessions = [];
    if (sharedPreferences!.getBool(AppString.isLogIn) ?? false) {
      if (FirebaseAuth.instance.currentUser!.email != AppString.email) {
        if (sharedPreferences!.getBool(AppString.isLogIn) ?? false) {
          sessions = await getDocSessions();
        }
        if (sessions.length < 10) {
          print("========================");
          print("${sessions.length}");
          if (state == AppLifecycleState.paused) {
            if (sharedPreferences!.getBool(AppString.isLogIn) ?? false) {
              sessions = await getDocSessions();
              sessions.add({
                "enterTime": sharedPreferences!.getString(AppString.sessions),
                "exitTime":
                    Timestamp.fromDate(DateTime.now()).seconds.toString(),
                "startPrecent": sharedPreferences!.getInt(AppString.precent),
                "endPrecent": await getDocPercent(),
              });
              updateSessions(session: sessions);
              sharedPreferences!.setInt(AppString.resumed, 1);
            }
            print("🔴 المستخدم خرج من التطبيق (في الخلفية)");
            print(Timestamp.fromDate(DateTime.now()).seconds.toString());
          } else if (state == AppLifecycleState.resumed) {
            if (sharedPreferences!.getBool(AppString.isLogIn) ?? false) {
              if (sharedPreferences!.getInt(AppString.resumed) == 1) {
                sharedPreferences!.setString(AppString.sessions,
                    Timestamp.fromDate(DateTime.now()).seconds.toString());

                sharedPreferences!
                    .setInt(AppString.precent, await getDocPercent());
                sharedPreferences!.setInt(AppString.resumed, 0);
                print("🟢 المستخدم عاد إلى التطبيق");
                print(Timestamp.fromDate(DateTime.now()).seconds.toString());
              }
              print("🟢 المستخدم عاد إلى التطبيق");
            }
          } else if (state == AppLifecycleState.detached) {
            if (sharedPreferences!.getBool(AppString.isLogIn) ?? false) {
              sessions = await getDocSessions();
              sessions.add({
                "enterTime": sharedPreferences!.getString(AppString.sessions),
                "exitTime":
                    Timestamp.fromDate(DateTime.now()).seconds.toString(),
                "startPrecent": sharedPreferences!.getInt(AppString.precent),
                "endPrecent": await getDocPercent(),
              });
              updateSessions(session: sessions);
              sharedPreferences!.setInt(AppString.resumed, 1);
            }
            print("⚫ التطبيق مغلق تمامًا");
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, fontFamily: "Poppins"),
      locale: const Locale('ar'),
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home:
          const SplashScreen(), //isLogIn ? const HomeScreen() : const SignUp(), //const TestScreen(),
      //const FirstExam(),
    );
  }
}
