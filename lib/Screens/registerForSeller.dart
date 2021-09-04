import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Screens/servicesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class RegisterSellerOne extends StatefulWidget {
  const RegisterSellerOne({Key? key}) : super(key: key);

  @override
  _RegisterSellerOneState createState() => _RegisterSellerOneState();
}

class _RegisterSellerOneState extends State<RegisterSellerOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text("REGISTER YOURSELF AS A", style:
              TextStyle(fontSize: 23, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
            ),
            Center(
              child: Text("SERVICE PROVIDER", style:
              TextStyle(fontSize: 23, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text("Select the type of Service:", style:
              TextStyle(fontSize: 15, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }
}
