import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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
late Map<String,dynamic> userSeller = {};
late Map<String,dynamic> categoryFetch = {};

// getToken() async {
//   SharedPreferences localStorage = await SharedPreferences.getInstance();
//   token = localStorage.getString('token');
// }

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
    backgroundColor: Colors.black54,
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

String roleOfUser ="";

getRoleUser() async{
  var res= await CallApi().postData({},'/getRole' );
  var body =json.decode(res.body);
  print(  body.toString());
  if(res.statusCode == 200){
    roleOfUser= body['roleName'];
  }
  print(roleOfUser.toString());
}

getSellerInfo() async {
  var res = await CallApi().postData( {},'/sells');
  var body = json.decode(res.body);
  if (body != null){
    if (body['success']!) {
     // print(body['profile']['title'].toString());
      SharedPreferences localStorage1 = await SharedPreferences.getInstance();
      localStorage1.setString('userSeller',json.encode(body['profile']) );
    }
  }
  return {
    'success':false,
    'message':'this user is not register as a service provider'
  };
}
//get images
imgFromCamera() async {
  final ImagePicker _picker = ImagePicker();
  XFile image = await _picker.pickImage(
      source: ImageSource.camera, imageQuality: 50
  ) as XFile;
  return image;
}
imgFromGallery() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var token = localStorage.getString('token');
  final ImagePicker _picker = ImagePicker();
  XFile image = await _picker.pickImage(
      source: ImageSource.gallery, imageQuality: 50
  ) as XFile;
  return image;
}

var sampleImage = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNWosb1JiswKwHTROhbee2jJvGPzIt-PInWg&usqp=CAU";

// test()
// async {
//   // https://jsonplaceholder.typicode.com/todos/1
//   Uri fullUrl = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
//   var resp = await http.get(
//     fullUrl,
//   );
//
//   if (resp.statusCode == 200) {
//     print('resp: '+resp.toString());
//     String data = resp.body;
//     //print('post resp: '+data.toString());
//     return jsonDecode(data);
//   } else {
//     return 'error';
//   }
// }