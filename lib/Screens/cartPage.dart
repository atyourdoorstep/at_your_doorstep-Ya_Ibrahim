import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/sellerProfileUpdate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCartPage extends StatefulWidget {
  const AddCartPage({Key? key}) : super(key: key);

  @override
  _AddCartPageState createState() => _AddCartPageState();
}

class _AddCartPageState extends State<AddCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                    ),
                    child: Image.network(sampleImage, fit: BoxFit.contain,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
