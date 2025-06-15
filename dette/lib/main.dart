import 'package:flutter/material.dart';
import 'screens/client_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des Dettes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ClientListScreen(),
    );
  }
}
