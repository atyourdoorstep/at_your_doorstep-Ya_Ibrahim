import 'package:at_your_doorstep/Constants.dart';
import 'package:at_your_doorstep/signuppage2.dart';
import 'package:flutter/material.dart';
import 'package:at_your_doorstep/textFieldClass.dart';
import 'package:blobs/blobs.dart';

import 'HomePage.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignupOperation();
  }
}

class SignupOperation extends StatefulWidget {

  @override
  _SignupOperationState createState() => _SignupOperationState();
}

class _SignupOperationState extends State<SignupOperation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Text("SIGN UP", style:
                        TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      textfieldStyle(textHint: 'First Name', obscureText: false, textLabel1: 'First Name ',),
                      textfieldStyle(textHint: 'Last Name', obscureText: false, textLabel1: 'Last Name ',),
                      textfieldStyle(textHint: 'CNIC', obscureText: false, textLabel1: 'CNIC ',),
                      textfieldStyle(textHint: 'Phone Number', obscureText: false, textLabel1: 'Phone Number ',),
                      //textfieldStyle(textHint: 'Home Address', obscureText: false, textLabel1: 'Home Address ',),
                      textfieldStyle(textHint: 'Date of Birth', obscureText: false, textLabel1: 'Date Of Birth ',),
                      textfieldStyle(textHint: 'Email Address', obscureText: false, textLabel1: 'Email Address ',),
                      textfieldStyle(textHint: 'Password', obscureText: true, textLabel1: 'Password',),
                      textfieldStyle(textHint: 'Confirm Password', obscureText: true, textLabel1: 'Confirm Password ',),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 55,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              },
                              color: Colors.red,
                              child: Text("Next", style:
                              TextStyle(fontSize: 18, color: Colors.white, fontFamily: "PTSans" )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}