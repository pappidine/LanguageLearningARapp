import 'package:flutter/material.dart';
// import 'package:testproject/dashboard_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Learning App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book_rounded,
              size: 120,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 40),
            Text(
              'Welcome to the Language Learning App!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/translator');
              break;
            case 1:
              Navigator.pushNamed(context, '/quiz');
              break;
            case 2:
              Navigator.pushNamed(context, '/dashboard');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt,
              color: Theme.of(context).colorScheme.secondary,
            ),
            label: 'Translator',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.quiz,
              color: Theme.of(context).colorScheme.secondary,
            ),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.secondary,
            ),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }
}
