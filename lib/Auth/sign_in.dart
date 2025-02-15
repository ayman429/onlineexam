import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:onlineexam/Auth/sign_up.dart';

import '../core/constant/app_color.dart';
import '../core/constant/app_string.dart';
import '../core/constant/auth_error.dart';
import '../core/constant/shared_pref.dart';
import '../core/firebase/firebase_get_doc_percent.dart';
import '../exam/admin.dart';
import '../exam/home.dart';

import 'components/custom_button_auth.dart';
import 'components/email_text_field.dart';
import 'components/password_text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  Object? error;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor3,
        surfaceTintColor: AppColor.backgroundColor3,
        shadowColor: const Color(0xFFc9d3de),
        elevation: 4,
        title: const Text(
          AppString.signIn,
          style: TextStyle(
              color: AppColor.textColor1,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset('assets/animations/animation1.json'),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    error != null
                        ? Text(
                            AuthError.authErrorFunc(error.toString()),
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 10),
                    EmailTextField(
                      emailController: emailController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'الحقل مطلوب';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    PasswordTextField(
                      passwordController: passwordController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'الحقل مطلوب';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButtonAuth(
                      text: AppString.signIn,
                      isloading: isLoading,
                      onPressed: () async {
                        try {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            final credential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                            log(credential.user!.uid);
                            setState(() {
                              error = null;
                              isLoading = false;
                            });

                            sharedPreferences!.setBool(AppString.isLogIn, true);
                            //----------------------------------------------
                            sharedPreferences!.setString(
                                AppString.sessions,
                                Timestamp.fromDate(DateTime.now())
                                    .seconds
                                    .toString());

                            sharedPreferences!.setInt(
                                AppString.precent, await getDocPercent());

                            //----------------------------------------------
                            // sharedPreferences!.setInt(
                            //     AppString.precent, await getDocPercent());
                            print("======================");
                            print(credential.user!.email);
                            if (credential.user!.email == AppString.email) {
                              sharedPreferences!
                                  .setBool(AppString.isAdmin, true);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AdminScreen(),
                                  ));
                            } else {
                              int precent = await getDocPercent();
                              sharedPreferences!
                                  .setInt(AppString.precent, precent);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(precent: precent),
                                  ));
                            }
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            log('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            log('Wrong password provided for that user.');
                          }
                          log("=================>$error");
                          setState(() {
                            isLoading = false;
                            error = e;
                          });
                        } catch (e) {
                          log("=================>$error");
                          setState(() {
                            isLoading = false;
                            error = e;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    MediaQuery.sizeOf(context).width < 300
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("ليس لديك حساب؟ ",
                                  style: TextStyle(
                                      color: AppColor.textColor1,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SignUp(),
                                      ));
                                },
                                child: const Text(
                                  AppString.signUp,
                                  style: TextStyle(
                                      color: AppColor.textColor3,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("ليس لديك حساب؟ ",
                                  style: TextStyle(
                                      color: AppColor.textColor1,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SignUp(),
                                      ));
                                },
                                child: const Text(
                                  AppString.signUp,
                                  style: TextStyle(
                                      color: AppColor.textColor3,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )

                    // CustomButtonAuth(
                    //   onPressed: () => signIn(
                    //       emailController: emailController,
                    //       passwordController: passwordController),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     print(
                    //         "userName: ${FirebaseAuth.instance.currentUser!.displayName}");
                    //   },
                    //   child: const Text("get user name"),
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
