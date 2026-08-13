import 'package:flutter/material.dart';
import 'package:truck_ledger_v2/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Truck Ledeger Version 2',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade700),
      ),
      home: const HomePage(),
    );
  }
}
