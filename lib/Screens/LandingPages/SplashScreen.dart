import 'dart:async';
import 'package:at_your_doorstep/Screens/LandingPages/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashState extends StatefulWidget {
  const SplashState({Key? key}) : super(key: key);

  @override
  _SplashStateState createState() => _SplashStateState();
}

class _SplashStateState extends State<SplashState> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (context) => MyHomePage(title: "At Your Doorstep")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 15,
        ),
        Center(
          child: Container(
              child: Center(child: Hero(
                  tag: 'logo',
                  child: Image.asset("assets/atyourdoorstep.png", height: 170,width: 170,)))),
        ),
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Center(
                child: Text("AT YOUR DOORSTEP", style:
                TextStyle(fontSize: 19, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
              ),
            ),
            CircularProgressIndicator(color: Colors.red,),
          ],
        ),
      ],
    );
  }
}