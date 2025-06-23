import 'package:animal_encyclopedia/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animal Encyclopedia',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: HomePage(),
    );
  }
}
