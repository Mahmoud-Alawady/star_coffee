import 'package:flutter/material.dart';
import 'package:star_coffee/app_constants/app_strings.dart';
import 'package:star_coffee/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      home: HomePage(),
    );
  }
}
