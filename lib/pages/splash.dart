import 'package:flutter/material.dart';
import 'dart:async';
import 'login.dart';

class SplashScreen extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () => Navigator.push(context, MaterialPageRoute(
      builder: (context) => LoginScreen()
    )));
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: 'logo',
          child: RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.white),
                children: <TextSpan>[
                  TextSpan(text: 'NASA\n', style: TextStyle(fontFamily: 'Nasa', fontSize: width/7)),
                  TextSpan(text: 'REBUILD', style: TextStyle(letterSpacing: 10, fontSize: width/20))
                ]
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
