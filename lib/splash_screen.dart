import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'Auth/sign_up.dart';
import 'core/constant/app_color.dart';
import 'core/constant/app_string.dart';
import 'core/constant/shared_pref.dart';
import 'core/firebase/firebase_get_doc_percent.dart';
import 'exam/admin.dart';
import 'exam/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false, isAdmin = false;
  int precent = 0;

  getPercent() async {
    precent = await getDocPercent();

    print('precent: $precent');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    isLogin = sharedPreferences!.getBool(AppString.isLogIn) ?? false;
    isAdmin = sharedPreferences!.getBool(AppString.isAdmin) ?? false;
    // Duration(seconds: 2);
    isLogin
        ? WidgetsBinding.instance.addPostFrameCallback((_) {
            getPercent();
          })
        : null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor1,
      body: AnimatedSplashScreen(
        backgroundColor: AppColor.backgroundColor1,
        animationDuration: const Duration(milliseconds: 500),
        splashTransition: SplashTransition.scaleTransition,
        splashIconSize: 500,
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                // color: Colors.amber,
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFc9d3de),
                    blurRadius: 6,
                    spreadRadius: 4,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/images/appIcon.webp',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      AppString.examsAppBarTitle,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        nextScreen: isLogin
            ? isAdmin
                ? AdminScreen()
                : HomeScreen(precent: precent)
            : const SignUp(),
        //const MyHomePage(),
      ),
    );
  }
}
