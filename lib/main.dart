import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/review_provider.dart'; // Import your ReviewProvider
import 'screens/home_screen.dart'; // Adjust this import as necessary

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ReviewProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.black87,
      ),
      home: const HomeScreen(), // Adjust this to your main screen
    );
  }
}
