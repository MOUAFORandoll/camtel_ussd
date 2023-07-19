import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'acceuil.dart';
import 'home.dart';
import 'homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tussd App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 3, 92)),
        useMaterial3: true,
      ),
      home: const AcceuilPage(),
    );
  }
}

