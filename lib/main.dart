import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/home/notes_page.dart';
import 'package:flutter_application_1/views/login/login_view.dart'; // Dodane import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Basics',
      home: LoginPage(),
      // Dodaj 'routes' i usuń 'home'
      routes: {
        '/home': (context) => const NotesPage(),
        // ... inne trasy, jeśli będziesz miał
      },
    );
  }
}
