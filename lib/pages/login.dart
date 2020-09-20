import 'package:flutter/material.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:nasa_rebuild/pages/home.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String name;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Image.asset(
            'assets/images/login_screen_bottom.jpg',
            scale: 3,
            ),
          ),
          Positioned(
            top: height/6,
            width: width,
            child: Center(
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
          Positioned(
            top: height/2.4,
            width: width,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: width/1.5,
                    child: Column(
                      children: [
                        Text(
                          'Your Name,',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width/18
                          ),
                        ),
                        TextField(
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            fillColor: Colors.blue,
                            focusColor: Colors.blue,
                            hoverColor: Colors.blue,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height/25,),
                  BouncingWidget(
                    duration: Duration(milliseconds: 150),
                    scaleFactor: 1.5,
                    onPressed: () async {
                      if (name != null) {
                        await Future.delayed(Duration(milliseconds: 500));
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => HomePage(name: name)));
                      }
                    },
                    child: Container(
                      height: height/18,
                      width: width/2.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(height)),
                      ),
                      child: Center(
                        child: Text(
                          'JOIN',
                          style: TextStyle(color: Colors.black, fontSize: height/50, letterSpacing: 10, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
