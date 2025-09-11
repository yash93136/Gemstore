import 'package:flutter/material.dart';
import 'package:gemstore/log_in.dart';
import 'package:gemstore/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Auth UI",
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.brown[900],
        inputDecorationTheme: const InputDecorationTheme(
          border: UnderlineInputBorder(),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.brown[200],
        inputDecorationTheme: const InputDecorationTheme(
          border: UnderlineInputBorder(),
        ),
      ),
      routes: {
        '/': (context) => LoginScreen(toggleTheme: toggleTheme),
        '/signup': (context) => SignUpScreen(toggleTheme: toggleTheme),
      },
    );
  }
}
