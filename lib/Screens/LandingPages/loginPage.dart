import 'dart:async';
import 'dart:convert';

import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/LandingPages/HomePage.dart';
import 'package:at_your_doorstep/Screens/SearchPage.dart';
import 'package:at_your_doorstep/Screens/SellerControl/registerForSeller.dart';
import 'package:at_your_doorstep/Screens/ServicesRelatedPages/requestNewService.dart';
import 'package:at_your_doorstep/Screens/SellerControl/sellerProfileUpdate.dart';
import 'package:at_your_doorstep/Screens/LandingPages/signup_page.dart';
import 'package:at_your_doorstep/Screens/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool showSpinner = false;
  var callApi= CallApi() ;
  bool _isLoading = false;
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String emailF = "mussabayubawan2@gmail.com";
  String passwordF = "mussabzgr8123";

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    //clearCSRFToken();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkStatus();
  }
  _checkStatus()async
  {
    EasyLoading.show(status: 'loading...');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token= await localStorage.getString('token');
    var user = ( await localStorage.getString('user'));
    if(token !=null&&token.length>0)
    {
      var resp= await CallApi().postData(token, '/getCurrentUser')  ;
      var body = json.decode(resp.body);
      if (body['success']!=null) {
        if (body['success']) {
          EasyLoading.dismiss();
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => CupertinoHomePage(userName:"LoginUser")));
        }
      }
      else {
        showMsg(context,'connection error');
      }
      // Navigator.push(
      //     context,
      //     new MaterialPageRoute(
      //         builder: (context) => HomePage()));
    }
    EasyLoading.dismiss();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children:[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(child: Hero(
                                          tag: 'logo',
                                          child: Image.asset("assets/atyourdoorstep.png", height: 150,width: 150,))),
                                    )),
                              ),
                              VerticalDivider(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text("Welcome to AYD!", style:
                                      TextStyle(fontSize: 17, color: Colors.black45, fontFamily: "PTSans", fontWeight: FontWeight.w300)),
                                    ),
                                    Center(
                                      child: Text("SIGN IN", style:
                                      TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w800 , letterSpacing: 2.0)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Center(
                        //   child: Text("SIGN IN", style:
                        //   TextStyle(fontSize: 25, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                        // ),
                        SizedBox(
                          height: 30,
                        ),
                        textfieldStyle(textHint: 'Email Address', obscureText: false, textLabel1: 'Email Address',controllerText: mailController,inputAction: TextInputAction.next,),
                        textfieldStyle(textHint: 'password', obscureText: true, textLabel1: 'Password ',controllerText: passwordController,inputAction: TextInputAction.done),
                        AYDButton(
                          buttonText: "Login",
                          onPressed: () async {
                            if(mailController.text != ""&& passwordController!=""){
                              setState(() {
                                showSpinner = true;
                              });
                              var data = {
                                'email' : mailController.text,
                                'password' : passwordController.text
                              };
                              login(data);
                            }
                            else{
                              showMsg(context, 'Please fill the above fields');
                            }
                            //EasyLoading.dismiss();
                          },
                        ),
                        AYDOutlinedButton(
                          buttonText: "Signup",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()),
                            );
                          },
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          children: [
                            buildDivider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text("OR", style:
                              TextStyle(color: Color(0xFFD9D9D9), fontFamily: "PTSans" )),
                            ),
                            buildDivider(),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AYDWithoutOutlinedButton(
                          buttonText: "As a Guest",
                          onPressed: () async {
                            var user={
                              'fName':'Guest',
                              'lName':'Account',
                              'CNIC':0,
                              'contact':0,
                              'email':''};
                            await toLocal('user',json.encode(user));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CupertinoHomePage(userName: "Guest")),
                            );
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );


  }

  Expanded buildDivider(){
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),);
  }

  // _showMsg(msg) { //
  //   final snackBar = SnackBar(
  //     backgroundColor: Color(0xffc76464),
  //     content: Text(msg),
  //     action: SnackBarAction(
  //       textColor: Colors.white,
  //       label: 'Close',
  //       onPressed: () {
  //         // Some code to undo the change!
  //       },
  //     ),
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
  toLocal(String key,String val)async
  {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(key, val);
  }
  void login(var data ) async {
    setState(() {
      _isLoading = true;
    });
    // var data = {
    //   'email' : mailController.text,
    //   'password' : passwordController.text
    // };

    EasyLoading.show(status: 'loading...');
    var res = await CallApi().postData(data, '/mobileLogin');
    Response resp=res;
    print(resp.statusCode);
    var body = json.decode(res.body);
    EasyLoading.dismiss();
    if (body != null){
      if(body['success']!=null) {
        if (body['success']) {
          SharedPreferences localStorage = await SharedPreferences
              .getInstance();
          localStorage.setString('token', body['token']);
          localStorage.setString('user', json.encode(body['user']));
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => CupertinoHomePage(userName: "loginUser",)));
        } else {
          showMsg(context, body['message']);
          //EasyLoading.showToast(body['message']);
        }
      }
      else
      {
        showMsg(context,'Communication Error');
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

}