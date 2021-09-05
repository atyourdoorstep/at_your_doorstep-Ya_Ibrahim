import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

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

const menuFont = TextStyle(
    color: Colors.black,
    fontSize: 18.0,
    decorationColor: Colors.black,
    fontFamily: "PTSans",
    fontWeight: FontWeight.w300,
);

late Map<String,dynamic> userD = {};
void logout(BuildContext context) async{

  // logout from the server ...
  var res = await CallApi().postData({},'/mobileLogOut');
  var body = json.decode(res.body);
  if(body['success']||(!body['success']&&body['message'].toString()=='Token has expired')){
    if((!body['success']&&body['message'].toString()=='Token has expired'))
      {
        showMsg(context, 'Session expired please login again');
      }
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('token');
    Navigator.of(
      context,
      rootNavigator: true,).pushNamed('LoginPage');
    Navigator.pop(context);
  }

}
showMsg(BuildContext context,msg) { //
  final snackBar = SnackBar(
    backgroundColor: Color(0xffc76464),
    content: Text(msg),
    action: SnackBarAction(
      textColor: Colors.white,
      label: 'Close',
      onPressed: () {
        // Some code to undo the change!
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
ucFirst(String str)
{
  if(str.isEmpty)
    return null;
  if(str.length<=1)
    return str.toUpperCase();
  var x=str.toString();
  return x.substring(0,1).toUpperCase()+x.substring(1).toLowerCase();
}
bool load = false;
getProfilePicture()
async {
  var res= await CallApi().postData({},'/getProfilePicture' );
  var body =json.decode(res.body);
print(  body.toString());
  if(res.statusCode == 200) {
    if (body['url']
        .toString()
        .length > 0) {
      profilePicUrl = body['url'];
      print(body['success'].toString());
    }
    load = true;
  }
return profilePicUrl;
}
String profilePicUrl='https://www.pngfind.com/pngs/m/676-6764065_default-profile-picture-transparent-hd-png-download.png';
