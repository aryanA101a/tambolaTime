import 'package:flutter/material.dart';
import 'package:tambola_time/tambola_screen.dart';

//starting point of the app
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //topMost widget
    return MaterialApp(
      home: TambolaScreen(),
    );
  }
}
