import 'dart:convert';

import 'package:at_your_doorstep/Constants.dart';
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
    return Container(
      color: Colors.yellow,
      child: Center(child: Text("Profile")),
    );
  }
}
