import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const LessMeatCalendarApp());
}

class LessMeatCalendarApp extends StatelessWidget {
  const LessMeatCalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LessMeatCalendar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
