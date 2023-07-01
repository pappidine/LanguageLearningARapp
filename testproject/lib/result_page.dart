import 'package:flutter/material.dart';
import 'package:testproject/quiz_page.dart';


class ResultPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
   final double average;

  const ResultPage({super.key, 
    required this.correctAnswers,
    required this.totalQuestions, 
    required this.average,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quiz Completed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Correct Answers: $correctAnswers',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Total Questions: $totalQuestions',
              style: const TextStyle(fontSize: 18),
            ),
             Text(
              'Average: $average',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
             onPressed: () {
             Navigator.pushAndRemoveUntil(
               context,
               MaterialPageRoute(builder: (context) => const QuizPage()),
              (route) => false,
         );
  },
  child: const Text('Try Again'),
),
          ],
        ),
      ),
    );
  }
}
