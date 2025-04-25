import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 135, 205, 138)),
        useMaterial3: true,
      ),
      home: InstructorDashboard(),
    );
  }
}

class InstructorDashboard extends StatefulWidget {
  @override
  _InstructorDashboardState createState() => _InstructorDashboardState();
}

class _InstructorDashboardState extends State<InstructorDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  String instructorName = 'Instructor';

  @override
  void initState() {
    super.initState();
    fetchInstructorName();
  }

  Future<void> fetchInstructorName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        setState(() {
          instructorName = doc.data()?['name'] ?? 'Instructor';
        });
      }
    } catch (e) {
      print('Error fetching instructor name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: Colors.grey.shade200,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 135, 205, 138), Color.fromARGB(255, 135, 205, 138)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 40, color: Color.fromARGB(255, 135, 205, 138)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      instructorName,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 135, 205, 138),
        elevation: 8,
        title: Text(
          'Welcome, $instructorName!',
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
             
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                buildCard(Icons.person, 'Profile Overview', Colors.lightBlue.shade50, Colors.lightBlue.shade700),
                buildCard(Icons.book, 'Course Management', Colors.amber.shade50, Colors.amber.shade700),
                buildCard(Icons.videocam, 'Live Sessions', Colors.teal.shade50, Colors.teal.shade700),
                buildCard(Icons.assignment, 'Assessments', Colors.pink.shade50, Colors.pink.shade700),
                buildCard(Icons.bar_chart, 'Announcement', Colors.purple.shade50, Colors.purple.shade700),
                buildCard(Icons.notifications, 'Notifications', Colors.orange.shade50, Colors.orange.shade700),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color.fromARGB(255, 135, 205, 138),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade300,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget buildCard(IconData icon, String title, Color backgroundColor, Color iconColor) {
    return GestureDetector(
      onTap: () {

      },
      child: Card(
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: iconColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
