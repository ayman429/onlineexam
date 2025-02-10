import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../Auth/sign_in.dart';
import '../core/constant/app_color.dart';
import '../core/constant/app_string.dart';
import '../core/constant/shared_pref.dart';
import 'widgets/custom_name_item.dart';
import 'widgets/leader_board.dart';
import 'widgets/users_analysis.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);
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
          "تحليلات",
          style: TextStyle(
              color: AppColor.textColor1,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignIn()));
            sharedPreferences!.setBool(AppString.isLogIn, false);
            // sharedPreferences!.setInt(AppString.precent, 0);
            sharedPreferences!.setBool(AppString.isAdmin, false);
          },
          icon: const Icon(
            Icons.logout,
            color: AppColor.iconColor2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Lottie.asset('assets/animations/animation6.json'),
              const SizedBox(height: 20),
              CustomNameItem(
                itemName: "قائمة المتصدرين",
                icon: FontAwesomeIcons.trophy,
                color: Colors.yellow[800],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowUsersAnswers(),
                      ));
                },
              ),
              CustomNameItem(
                itemName: "تحليلات المستخدمين",
                icon: Icons.leaderboard,
                color: AppColor.textColor3,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UsersAnalysis(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
