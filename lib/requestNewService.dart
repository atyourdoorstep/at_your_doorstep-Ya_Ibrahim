import 'dart:async';
import 'dart:convert';
import 'package:at_your_doorstep/Constants.dart';
import 'package:at_your_doorstep/SearchPage.dart';
import 'package:at_your_doorstep/api.dart';
import 'package:at_your_doorstep/servicesCategory.dart';
import 'package:at_your_doorstep/userProfile.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

class SuggestNewService extends StatefulWidget {
  const SuggestNewService({Key? key}) : super(key: key);

  @override
  _SuggestNewServiceState createState() => _SuggestNewServiceState();
}

class _SuggestNewServiceState extends State<SuggestNewService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text(userD['email'].toString()),
      ),
    );
  }
}
