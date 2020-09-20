import 'package:flutter/material.dart';
import 'package:nasa_rebuild/pages/home.dart';
import 'package:nasa_rebuild/pages/splash.dart';
import 'pages/earth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}