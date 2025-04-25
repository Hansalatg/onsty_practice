import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const StudentDashboard(),
    );
  }
}

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 8,
        title: const Text(
          'Welcome, Student!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            buildCard(Icons.book, 'View Courses', Colors.blue.shade50, Colors.blue.shade700),
            buildCard(Icons.video_call, 'Live Sessions', Colors.green.shade50, Colors.green.shade700),
            buildCard(Icons.assignment, 'My Assessments', Colors.purple.shade50, Colors.purple.shade700),
            buildCard(Icons.bar_chart, 'Track Progress', Colors.orange.shade50, Colors.orange.shade700),
            buildCard(Icons.campaign, 'Announcements', Colors.teal.shade50, Colors.teal.shade700),
            buildCard(Icons.alarm, 'Reminders', Colors.pink.shade50, Colors.pink.shade700),
          ],
        ),
      ),
    );
  }

  Widget buildCard(IconData icon, String title, Color backgroundColor, Color iconColor) {
    return Card(
      color: backgroundColor,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: iconColor),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
