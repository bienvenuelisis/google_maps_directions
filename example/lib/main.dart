import 'package:flutter/material.dart';

import 'screens/distance_between_two_points.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Distance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DistanceBetweenTwoPoints(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
