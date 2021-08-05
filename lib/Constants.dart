import 'package:flutter/material.dart';

const hintStyleForTextField = TextStyle(
    color: Colors.black26, fontSize: 15.0, decorationColor: Colors.black);
const newFont = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    decorationColor: Colors.black,
    fontFamily: "PTSans");

const newFontRed = TextStyle(
  color: Colors.red,
  fontSize: 10.0,
  decorationColor: Colors.black,
);

const taskPageColorsbg = Color(0xFFFAFAFA);

const boldFont = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
    decorationColor: Colors.black,
    fontFamily: "PTSans");

const headingColor = Colors.grey;

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.red,
  minimumSize: Size(90,50),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);