import 'package:flutter/material.dart';

class ExitScreen2 extends StatefulWidget {
  const ExitScreen2({super.key});

  @override
  _ExitScreen2State createState() => _ExitScreen2State();
}

class _ExitScreen2State extends State<ExitScreen2> with WidgetsBindingObserver {
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      print("🔴 المستخدم خرج من التطبيق (في الخلفية)");
    } else if (state == AppLifecycleState.resumed) {
      print("🟢 المستخدم عاد إلى التطبيق");
    } else if (state == AppLifecycleState.detached) {
      print("⚫ التطبيق مغلق تمامًا");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اختبار حالة التطبيق')),
      body: const Center(child: Text('جرب الخروج من التطبيق ثم العودة!')),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class ExitScreen extends StatefulWidget {
//   const ExitScreen({super.key});

//   @override
//   _ExitScreenState createState() => _ExitScreenState();
// }

// class _ExitScreenState extends State<ExitScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _lockScreen();
//   }

//   void _lockScreen() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//   }

//   // void _unlockScreen() {
//   //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//   // }

//   // @override
//   // void dispose() {
//   //   _unlockScreen();
//   //   super.dispose();
//   // }

//   Future<bool> _onWillPop() async {
//     return false; // منع الرجوع للخلف نهائيًا
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         appBar: AppBar(title: const Text("الامتحان")),
//         body: const Center(child: Text("أسئلة الامتحان هنا")),
//       ),
//     );
//   }
// }
