// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:onlineexam/core/constant/app_string.dart';

import '../../Auth/sign_in.dart';
import '../../Auth/reset_password.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/shared_pref.dart';

import '../../core/firebase/firebase_get_doc_percent.dart';
import '../../core/firebase/firebase_get_doc_sessions.dart';
import '../../core/firebase/firebase_update_user_info.dart';
import '../admin.dart';

import '../study_home.dart';
import 'show_user_answers.dart';
import 'leader_board.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: AppColor.backgroundColor1,
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/img2.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SizedBox(),
              ),
              SizedBox(height: 20),
              ListTile(
                dense: true,
                leading: Icon(
                  FontAwesomeIcons.trophy,
                  color: Colors.yellow[800],
                ),
                title: const Text(
                  "قائمة المتصدرين",
                  style: TextStyle(
                    color: AppColor.textColor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowUsersAnswers(),
                      ));
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 5,
                  color: AppColor.backgroundColor3,
                ),
              ),
              ListTile(
                dense: true,
                leading: Icon(
                  Icons.picture_as_pdf,
                  color: Colors.red,
                ),
                title: const Text(
                  "مساعدة",
                  style: TextStyle(
                    color: AppColor.textColor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudyHome(),
                      ));
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 5,
                  color: AppColor.backgroundColor3,
                ),
              ),

              ListTile(
                dense: true,
                leading: Icon(
                  Icons.edit_square,
                  color: Colors.green,
                ),
                title: const Text(
                  AppString.postExamTitle,
                  style: TextStyle(
                    color: AppColor.textColor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowUserAnswers(),
                      ));
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 5,
                  color: AppColor.backgroundColor3,
                ),
              ),
              ListTile(
                dense: true,
                leading: Icon(
                  Icons.password,
                  color: AppColor.textColor3,
                ),
                title: const Text(
                  AppString.resetPassword,
                  style: TextStyle(
                    color: AppColor.textColor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPassword(),
                      ));
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 5,
                  color: AppColor.backgroundColor3,
                ),
              ),

              ListTile(
                dense: true,
                leading: const Icon(
                  Icons.logout,
                  color: AppColor.iconColor2,
                ),
                title: const Text(
                  'تسجيل الخروج',
                  style: TextStyle(
                    color: AppColor.textColor3,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.rightSlide,
                    title: 'تحذير',
                    // desc: "إذا كنتَ لا تتذكر كلمة المرور، فعليك تغييرها أولًا.",
                    // descTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                    body: Column(
                      children: [
                        const Text(
                          "إذا كنتَ لا تتذكر كلمة المرور، فعليك تغييرها أولًا.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'هل أنت متأكد من تسجيل الخروج؟',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    btnOkText: 'نعم',
                    btnCancelText: 'لا',
                    btnOkOnPress: () async {
                      print('ok');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()));
                      sharedPreferences!.setBool(AppString.isLogIn, false);
                      // sharedPreferences!.setInt(AppString.precent, 0);
                      sharedPreferences!.setBool(AppString.isAdmin, false);
                      //----------------------------------
                      List sessions = [];
                      sessions = await getDocSessions();
                      sessions.add({
                        "enterTime":
                            sharedPreferences!.getString(AppString.sessions),
                        "exitTime": Timestamp.fromDate(DateTime.now())
                            .seconds
                            .toString(),
                        "startPrecent":
                            sharedPreferences!.getInt(AppString.precent),
                        "endPrecent": await getDocPercent(),
                      });
                      updateSessions(session: sessions);
                      // sharedPreferences!.setInt(AppString.resumed, 1);
                      //----------------------------------
                    },
                    btnCancelOnPress: () {
                      print('cancel');
                    },
                  ).show();
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 5,
                  color: AppColor.backgroundColor3,
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.2,
              // ),
              SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: Lottie.asset(
                  'assets/animations/animation1.json',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<dynamic> showDialogAnswer(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text("لم تقم بحل الاختبار بعد"),
  //         content: const Text(
  //           "قم بحل الاختبار اولا",
  //           style: TextStyle(fontSize: 20),
  //         ),
  //         actions: [
  //           Center(
  //             child: TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text(
  //                 "موافق",
  //                 style: TextStyle(color: AppColor.primaryColor, fontSize: 16),
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
