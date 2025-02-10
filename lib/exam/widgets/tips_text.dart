import 'package:flutter/material.dart';

import '../../core/constant/app_color.dart';

class TipsText extends StatelessWidget {
  const TipsText({super.key, required this.value});
  final int value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TipsTitle(title: "إرشادات هامة قبل بدء الاختبار الإلكتروني:"),
          const TipsItem(
            text: '''مرحبًا بكم في اختباركم عبر تطبيق "أساسيات التصوير الرقمي"!
يُرجى قراءة التعليمات التالية بعناية لضمان تجربة اختبار سلسة وخالية من المشاكل.''',
          ),
          const SizedBox(height: 10),
          const TipsTitle(title: "التعليمات العامة:"),
          const TipsItem(
              text: '''تأكد من أن هاتفك متصل بالإنترنت بشكل جيد ومستقر.
احرص على أن يكون هاتفك مشحونًا بالكامل أو موصولًا بالشاحن أثناء الاختبار.
يُفضَّل الجلوس في مكان هادئ بعيدًا عن أي مشتتات لضمان التركيز.'''),
          const SizedBox(height: 10),
          value == 0 || value == 6
              ? const TipsTitle(title: "كيفية التنقل بين الأسئلة:")
              : const SizedBox(),
          value == 0 || value == 6
              ? const TipsItem(
                  text:
                      '''ستظهر على الجانب الأيمن من الشاشة دوائر مرقمة تمثل أسئلة الاختبار، مع دلالات الألوان التالية:
أبيض: لم يتم الدخول إلى السؤال بعد.
أحمر: تم الدخول إلى السؤال ولكن لم يتم حفظ الإجابة.
أخضر: تم حفظ الإجابة بنجاح.
يمكنك التنقل بين الأسئلة عبر الضغط على أرقامها في الدوائر.''')
              : const SizedBox(),
          const SizedBox(height: 30),
        ],
      ),
    );
//     Scaffold(
//       backgroundColor: AppColor.backgroundColor1,
//       appBar: AppBar(
//         backgroundColor: AppColor.backgroundColor3,
//         title: const Text(
//           "إرشادات",
//           style: TextStyle(
//               color: AppColor.textColor1,
//               fontSize: 22,
//               fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_new,
//             color: AppColor.textColor3,
//           ),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const TipsTitle(
//                         title: "إرشادات هامة قبل بدء الاختبار الإلكتروني:"),
//                     const TipsItem(
//                       text:
//                           '''مرحبًا بكم في اختباركم عبر تطبيق "أساسيات التصوير الرقمي"!
// يُرجى قراءة التعليمات التالية بعناية لضمان تجربة اختبار سلسة وخالية من المشاكل.''',
//                     ),
//                     const SizedBox(height: 10),
//                     const TipsTitle(title: "التعليمات العامة:"),
//                     const TipsItem(
//                         text:
//                             '''تأكد من أن هاتفك متصل بالإنترنت بشكل جيد ومستقر.
// احرص على أن يكون هاتفك مشحونًا بالكامل أو موصولًا بالشاحن أثناء الاختبار.
// يُفضَّل الجلوس في مكان هادئ بعيدًا عن أي مشتتات لضمان التركيز.'''),
//                     const SizedBox(height: 10),
//                     value == 0 || value == 6
//                         ? const TipsTitle(title: "كيفية التنقل بين الأسئلة:")
//                         : const SizedBox(),
//                     value == 0 || value == 6
//                         ? const TipsItem(
//                             text:
//                                 '''ستظهر على الجانب الأيمن من الشاشة دوائر مرقمة تمثل أسئلة الاختبار، مع دلالات الألوان التالية:
// أبيض: لم يتم الدخول إلى السؤال بعد.
// أحمر: تم الدخول إلى السؤال ولكن لم يتم حفظ الإجابة.
// أخضر: تم حفظ الإجابة بنجاح.
// يمكنك التنقل بين الأسئلة عبر الضغط على أرقامها في الدوائر.''')
//                         : const SizedBox(),
//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
  }
}

class TipsTitle extends StatelessWidget {
  const TipsTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.textColor3),
      ),
    );
  }
}

class TipsItem extends StatelessWidget {
  const TipsItem({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color:
            //Colors.transparent,
            AppColor.backgroundColor4,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFc9d3de),
            blurRadius: 6,
            spreadRadius: 4,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.textColor1),
      ),
    );
  }
}
