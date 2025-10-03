import 'package:firebase_core/firebase_core.dart';
import 'package:wildsnap/screens/main_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialise les Widgets
  await Firebase.initializeApp( // Initialise la connexion avec Firebase
  options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WildSnap',
      theme: ThemeData(
        scaffoldBackgroundColor: (Colors.white),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainScreen(),
    );
  }
}
