import 'dart:convert';

import 'package:at_your_doorstep/Constants.dart';
import 'package:at_your_doorstep/HomePage.dart';
import 'package:at_your_doorstep/api.dart';
import 'package:at_your_doorstep/main.dart';
import 'package:at_your_doorstep/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:at_your_doorstep/textFieldClass.dart';
import 'package:blobs/blobs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class editProfile extends StatelessWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EditProfileOp();
  }
}

class EditProfileOp extends StatefulWidget {
  const EditProfileOp({Key? key}) : super(key: key);

  @override
  _EditProfileOpState createState() => _EditProfileOpState();
}

class _EditProfileOpState extends State<EditProfileOp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello!", style:
                        TextStyle(fontSize: 16, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w500 )),
                        Text("Your Name", style:
                        TextStyle(fontSize: 25, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0),
                      ),),
                    child: ListView(
                      physics: ClampingScrollPhysics(),
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()),);
                          },
                          child: ListTile(title: Text("Edit Profile", style: menuFont,),
                          leading: Icon(Icons.edit),
                          ),
                        ),
                        Divider(),
                        ListTile(title: Text("Orders", style: menuFont,),
                          leading: Icon(Icons.shopping_bag_outlined),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //
              SizedBox(
                height: 280,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0),
                      ),),
                    child: ListView(
                      physics: ClampingScrollPhysics(),
                      children: [
                        ListTile(title: Text("Complaints", style: menuFont,),
                          leading: Icon(Icons.edit),
                        ),
                        Divider(),
                        ListTile(title: Text("Suggest New Service", style: menuFont,),
                          leading: Icon(Icons.add_chart),
                        ),
                        Divider(),
                        ListTile(title: Text("My Address", style: menuFont,),
                          leading: Icon(Icons.location_on),
                        ),
                        Divider(),
                        ListTile(title: Text("Sign Out", style: menuFont,),
                          leading: Icon(Icons.power_settings_new),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child:  Column(
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
                        child: Text("EDIT PROFILE", style:
                        TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      textfieldStyle(textHint: 'First Name', obscureText: false, textLabel1: 'First Name '),
                      textfieldStyle(textHint: 'Last Name', obscureText: false, textLabel1: 'Last Name '),
                      textfieldStyle(textHint: 'Email', obscureText: false, textLabel1: 'CNIC ',),
                      textfieldStyle(textHint: 'Phone Number', obscureText: false, textLabel1: 'Phone Number ',),
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
                                   },
                              color: Colors.red,
                              child: Text("Save", style:
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
      ),
    );
  }
}



//onPressed: () {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//         builder: (context) => text()),
//   );
// },