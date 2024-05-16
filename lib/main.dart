import 'package:flutter/material.dart';
import 'package:pomodoro_clone/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        dialogBackgroundColor: const Color(0xFFE7626C),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: Colors.white,
      ),
      home: const Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
