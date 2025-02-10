// import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../core/constant/app_color.dart';
import '../core/constant/app_string.dart';
import '../core/constant/auth_error.dart';

import 'components/custom_button_auth.dart';

import 'components/password_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
        surfaceTintColor: AppColor.backgroundColor3,
        shadowColor: const Color(0xFFc9d3de),
        elevation: 4,
        title: Text(
          AppString.resetPassword,
          style: TextStyle(
              color: AppColor.textColor1,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.textColor3,
          ),
        ),
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
                      text: AppString.resetPassword,
                      isloading: isLoading,
                      onPressed: () async {
                        try {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });

                            await FirebaseAuth.instance.currentUser!
                                .updatePassword(passwordController.text);
                            setState(() {
                              isLoading = false;
                              error = null;
                            });
                            Navigator.pop(context);
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
