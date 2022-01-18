import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/paymentPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AskMeAnything extends StatefulWidget {
  const AskMeAnything({Key? key}) : super(key: key);

  @override
  _AskMeAnythingState createState() => _AskMeAnythingState();
}

class _AskMeAnythingState extends State<AskMeAnything> {

  TextEditingController questController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ask me Anything", style: TextStyle(fontSize: 15,
          color: Colors.red,
          fontFamily: "PTSans",
          fontWeight: FontWeight.w500,),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: (){},
              icon: Icon(Icons.mark_chat_unread_sharp, size: 30, color: Colors.red,),
            ),
          ),
          // Text("Asked Questions", style: TextStyle(
          //   color: Colors.red,
          //   fontFamily: "PTSans",
          //   fontWeight: FontWeight.w500,),),
        ],
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
        ),
      ),
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("ASK ME!", style:
              TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
            ),
            SizedBox(height: 15),
            textfieldStyle(textHint: "Discount mil jy ga?", obscureText: false, textLabel1:'Type your Question...', controllerText: questController,),
            SizedBox(
              height: 5,
            ),
            AYDButton(
              onPressed: (){},
              buttonText: "Submit",
            ),
          ],
        ),
      ),
    );
  }
}
