import 'package:flutter/material.dart';

class AYDButton extends StatelessWidget {

  final onPressed;
  final buttonText;
  AYDButton({this.onPressed, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(buttonText, style:
          TextStyle(fontSize: 18, color: Colors.white, fontFamily: "PTSans" )),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            fixedSize: Size(double.maxFinite,55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ),
    );
  }
}

class AYDOutlinedButton extends StatelessWidget {
  final onPressed;
  final buttonText;
  AYDOutlinedButton({this.onPressed, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Padding(
        padding:  const EdgeInsets.only(left: 10.0, right: 10.0),
        child: OutlinedButton(
          onPressed: onPressed,
          child: Text(buttonText, style:
          TextStyle(fontSize: 18, color: Colors.red, fontFamily: "PTSans" )),
          style: OutlinedButton.styleFrom(
            primary: Colors.red,
            fixedSize: Size(double.maxFinite,55),
            side: BorderSide(color: Colors.red),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ),
    );
  }
}

class AYDWithoutOutlinedButton extends StatelessWidget {
  final onPressed;
  final buttonText;
  AYDWithoutOutlinedButton({this.onPressed, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Padding(
        padding:  const EdgeInsets.only(left: 10.0, right: 10.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(buttonText, style:
          TextStyle(fontSize: 18, color: Colors.red, fontFamily: "PTSans" )),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            fixedSize: Size(double.maxFinite,55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ),
    );
  }
}
