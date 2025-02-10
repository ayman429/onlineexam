// import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:onlineexam/Auth/sign_in.dart';

import '../core/constant/app_color.dart';
import '../core/constant/app_string.dart';
import '../core/constant/auth_error.dart';
import '../core/constant/shared_pref.dart';
import '../core/firebase/firebase_add_user_info.dart';
import '../core/firebase/firebase_get_doc_percent.dart';
import '../exam/home.dart';
import 'components/custom_button_auth.dart';
import 'components/email_text_field.dart';
import 'components/name_text_field.dart';
import 'components/password_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
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
        title: const Text(
          AppString.signUp,
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
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
                    NameTextField(
                      nameController: nameController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'الحقل مطلوب';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
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
                      text: AppString.signUp,
                      isloading: isLoading,
                      onPressed: () async {
                        try {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            // final credential =
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            // log(credential.user!.uid);
                            await FirebaseAuth.instance.currentUser!
                                .updateDisplayName(nameController.text);
                            // await FirebaseAuth.instance.currentUser!
                            // .updatePassword(newPassword);
                            setState(() {
                              isLoading = false;
                              error = null;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const HomeScreen(precent: 0),
                                ));
                            sharedPreferences!.setBool(AppString.isLogIn, true);
                            sharedPreferences!
                                .setBool(AppString.isAdmin, false);

                            await addUserData();
                            //----------------------------------------------
                            sharedPreferences!.setString(
                                AppString.sessions,
                                Timestamp.fromDate(DateTime.now())
                                    .seconds
                                    .toString());

                            sharedPreferences!.setInt(AppString.precent, 0);

                            //----------------------------------------------
                          }
                        } on FirebaseAuthException catch (e) {
                          // if (e.code == 'weak-password') {
                          //   log('The password provided is too weak.');
                          // } else if (e.code == 'email-already-in-use') {
                          //   log('The account already exists for that email.');
                          // }
                          setState(() {
                            isLoading = false;
                            error = e;
                          });
                          // log(error.toString());
                        } catch (e) {
                          // log("===========================>$e");
                          setState(() {
                            isLoading = false;
                            error = e;
                          });
                          // log("===========================>$error");
                        }
                      },
                    ),
                    const SizedBox(height: 20),

                    MediaQuery.sizeOf(context).width < 320
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("املك حساب بالفعل؟ ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppColor.textColor1,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SignIn(),
                                      ));
                                },
                                child: const Text(
                                  AppString.signIn,
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
                              const Text("املك حساب بالفعل؟ ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppColor.textColor1,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SignIn(),
                                      ));
                                },
                                child: const Text(
                                  AppString.signIn,
                                  style: TextStyle(
                                      color: AppColor.textColor3,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),

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
