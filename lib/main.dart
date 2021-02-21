import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rubiks_timer/screens/home_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF222831),
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Rubik's Timer",
      theme: ThemeData(
        backgroundColor: Color(0xFF222831),
      ),
      home: HomeScreen(),
    );
  }
}
