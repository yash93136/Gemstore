import 'package:flutter/material.dart';
import 'package:gemstore/screen/splasnscreen.dart';
import 'package:provider/provider.dart'; // Import provider

// ThemeManager क्लास को यहां जोड़ें या अगर आपने इसे theme_manager.dart में रखा है तो इम्पोर्ट करें
class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Default theme mode

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notify listeners (MaterialApp) about the change
  }
}


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeManager(), // Provide the ThemeManager
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // ThemeManager को सुनें
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp(
      title: 'Gemstore', // Your app title
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink, // आपका पसंदीदा प्राथमिक रंग
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
        // Light theme specific configurations
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.pink, // डार्क मोड के लिए भी समान प्राथमिक रंग या कोई और
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        // Dark theme specific configurations
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.grey.shade800,
        cardColor: Colors.grey.shade700,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white70),
          bodyMedium: TextStyle(color: Colors.white54),
        ),
      ),
      themeMode: themeManager.themeMode, // ThemeManager से थीम मोड का उपयोग करें
      home: const Splasnscreen(), // आपकी स्प्लैश स्क्रीन
    );
  }
}