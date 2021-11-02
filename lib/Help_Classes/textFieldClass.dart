import 'package:flutter/material.dart';
import 'Constants.dart';

class textfieldStyle extends StatelessWidget {
  final textLabel1;
  final keyBoardType;
  final Icon1;
  final String textHint;
  final onChange;
  final bool obscureText;
  final controllerText;
  final suffixButton;
  final submit;
  final focus;
  final contentP;
  final inputAction;
  final maxLength;

  textfieldStyle(
      {this.textLabel1, this.inputAction,this.maxLength,
        this.keyBoardType,
        this.Icon1,
        this.contentP,
        required this.textHint,
        this.onChange, this.submit,this.focus,
        required this.obscureText, this.controllerText, this.suffixButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0 , right: 12.0 , top: 2.0 ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
          textInputAction: inputAction,
          maxLength: maxLength,
          focusNode: focus,
          obscureText: obscureText,
          onChanged: onChange,
          controller: controllerText,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            suffixIcon: suffixButton,
            hintText: textHint,
            labelText: textLabel1,
            hintStyle: hintStyleForTextField,
            hoverColor: Colors.blue,
            contentPadding: contentP,
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