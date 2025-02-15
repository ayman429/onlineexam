import 'package:flutter/material.dart';

import '../core/constant/app_color.dart';
import '../core/constant/app_string.dart';
import 'widgets/custom_name_item.dart';
import 'widgets/pdfStudy.dart';

class StudyHome extends StatelessWidget {
  const StudyHome({Key? key}) : super(key: key);
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
          "المادة العلمية",
          style: TextStyle(
              color: AppColor.textColor1,
              fontSize: 22,
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
            // const SizedBox(height: 20),
            // Lottie.asset('assets/animations/animation6.json'),
            //img6.webp
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                // color: Colors.amber,
                borderRadius: BorderRadius.circular(30),
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
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/images/img6.webp',
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 50),
            CustomNameItem(
              itemName: AppString.exam1Title,
              icon: Icons.picture_as_pdf,
              color: Colors.red,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const pdfStudy(
                        pdf: "assets/pdf/exam1.pdf",
                        value: 1,
                        tipsExamAppBarTitle: AppString.exam1Title,
                      ),
                    ));
              },
            ),
            CustomNameItem(
              itemName: AppString.exam2Title,
              icon: Icons.picture_as_pdf,
              color: Colors.red,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const pdfStudy(
                        pdf: "assets/pdf/exam2.pdf",
                        value: 2,
                        tipsExamAppBarTitle: AppString.exam2Title,
                      ),
                    ));
              },
            ),
            CustomNameItem(
              itemName: AppString.exam3Title,
              icon: Icons.picture_as_pdf,
              color: Colors.red,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const pdfStudy(
                        pdf: "assets/pdf/exam3.pdf",
                        value: 3,
                        tipsExamAppBarTitle: AppString.exam3Title,
                      ),
                    ));
              },
            ),
            CustomNameItem(
              itemName: AppString.exam4Title,
              icon: Icons.picture_as_pdf,
              color: Colors.red,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const pdfStudy(
                        pdf: "assets/pdf/exam4.pdf",
                        value: 4,
                        tipsExamAppBarTitle: AppString.exam4Title,
                      ),
                    ));
              },
            ),
            CustomNameItem(
              itemName: AppString.exam5Title,
              icon: Icons.picture_as_pdf,
              color: Colors.red,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const pdfStudy(
                        pdf: "assets/pdf/exam5.pdf",
                        value: 5,
                        tipsExamAppBarTitle: AppString.exam5Title,
                      ),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
