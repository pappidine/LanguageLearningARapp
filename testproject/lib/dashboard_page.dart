import 'package:flutter/material.dart';
import 'package:testproject/quiz_page.dart';

class DashboardPage extends StatefulWidget {
  // const DashboardPage({super.key});

  final double dailyProgress;

  const DashboardPage({Key? key, required this.dailyProgress}) : super(key: key);

  


  @override

  // ignore: library_private_types_in_public_api
  _DashboardPageState createState() => _DashboardPageState();

}
class _DashboardPageState extends State<DashboardPage> {
  int _dailyProgress = 0;

  void _updateDailyProgress(int progress) {
    setState(() {
      _dailyProgress = progress;
    });
  }

  @override
  void initState() {
    super.initState();
    // Retrieve the daily progress from the QuizPage
    // Replace this with your logic to fetch the progress
    _updateDailyProgress(QuizPage.dailyProgress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard,
              size: 120,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 40),
            Text(
              'Welcome to the Dashboard!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Daily Progress: ${(_dailyProgress * 100).toStringAsFixed(2)}%',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
