// import 'package:flutter/material.dart';

// import '../../core/constant/app_string.dart';
// import '../functions/calculate_score.dart';
// import '../home.dart';

// class ScoreScreen extends StatelessWidget {
//   final List<int> userAnswers;
//   final List<int> rightAnswers;

//   const ScoreScreen({
//     super.key,
//     required this.userAnswers,
//     required this.rightAnswers,
//   });
//   @override
//   Widget build(BuildContext context) {
//     int score =
//         calculateScore(userAnswers: userAnswers, rightAnswers: rightAnswers);
//     return Scaffold(
//       backgroundColor: const Color(0xFF000518),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF62FCD7),
//         title: const Text(
//           AppString.score,
//           style: TextStyle(
//               color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Your Score: $score/${rightAnswers.length}',
//               style: const TextStyle(
//                 fontSize: 36,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const HomeScreen()));
//               },
//               child: const Text('Got to Home'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
