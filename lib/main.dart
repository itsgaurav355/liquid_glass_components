import 'package:flutter/material.dart';
import 'package:liquid_glass_components/example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Glass Components Demo',
      home: const ExamplePage(),
    );
  }
}
