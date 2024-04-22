import 'package:flutter/material.dart';
import 'package:prova_expermed/screens/login_screen.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expermed',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
