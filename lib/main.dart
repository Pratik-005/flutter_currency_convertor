import 'package:currency_converter/screens/home.dart';
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
      title: 'Currency Convertor',
      theme: ThemeData(
        fontFamily: 'DMSans',
        primaryColor: Colors.blueAccent,
        brightness: Brightness.dark,
      ),
      home: Home(),
      builder: (context, child) => SafeArea(child: child!),
    );
  }
}
