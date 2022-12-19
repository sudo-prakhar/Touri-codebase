import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/find_robot_screen/find_robot_screen.dart';
import 'package:frontend/screens/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}
/* ----------------------------------- APP ---------------------------------- */

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Touri App',
      theme: ThemeData.dark(),
      home: FindRobotScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
