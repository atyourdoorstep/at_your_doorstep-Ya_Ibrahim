import 'package:flutter/material.dart';
import 'Constants.dart';

class textfieldStyle extends StatelessWidget {
  final String textLabel1;
  final keyBoardType;
  final Icon1;
  final String textHint;
  final onChange;
  final bool obscureText;
  final controllerText;
  final suffixButton;

  textfieldStyle(
      {required this.textLabel1,
        this.keyBoardType,
        this.Icon1,
        required this.textHint,
        this.onChange,
        required this.obscureText, this.controllerText, this.suffixButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0 , right: 12.0 , top: 2.0 ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
          obscureText: obscureText,
          onChanged: onChange,
          controller: controllerText,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            //filled: true,
            //fillColor: Colors.black12,
            suffixIcon: suffixButton,
            hintText: textHint,
            labelText: textLabel1,
            hintStyle: hintStyleForTextField,
            hoverColor: Colors.blue,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black87),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          keyboardType: keyBoardType,
          style: TextStyle(
            fontFamily: "PTSans",
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}