import 'package:flutter/material.dart';
//import 'package:testproject/home_page.dart';
import 'package:testproject/translator_page.dart';
import 'package:testproject/quiz_page.dart';
import 'package:testproject/dashboard_page.dart';

void main() {
  runApp(const LanguageLearningApp());
}

class LanguageLearningApp extends StatelessWidget {
  const LanguageLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Learning App',
      theme: ThemeData(
        primaryColor: const Color(0xFF6C63FF), // Purple
        hintColor: const Color(0xFF00B4D8), // Teal
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/dashboard',
      routes: {
        // '/': (context) => const HomePage(),
        '/translator': (context) => const TranslatorPage(),
        '/quiz': (context) => const QuizPage(),
        '/dashboard': (context) => const DashboardPage(dailyProgress: 0.0),
      },
    );
  }
}
