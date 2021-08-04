import 'dart:convert';

import 'package:at_your_doorstep/Constants.dart';
import 'package:at_your_doorstep/HomePage.dart';
import 'package:at_your_doorstep/api.dart';
import 'package:at_your_doorstep/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:at_your_doorstep/textFieldClass.dart';
import 'package:blobs/blobs.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'api.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


void main()  {
  //runApp(HomePage());

  //return;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'At Your Doorstep',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.red,

      ),
      home: MyHomePage(title: 'At Your Doorstep'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
saveStringTolocal(String key,String value)async
{
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  localStorage.setString(key, value);
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
    //saveToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Image.asset("assets/atyourdoorstep.png", height: 180,width: 180,)),
                          )),
                      Center(
                        child: Text("LOG IN", style:
                        TextStyle(fontSize: 25, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      textfieldStyle(textHint: 'Email Address', obscureText: false, textLabel1: 'Email Address',controllerText: mailController,),
                      textfieldStyle(textHint: 'password', obscureText: true, textLabel1: 'Password ',controllerText: passwordController,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 55,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              onPressed: () async {
                                setState(() {
                                  showSpinner = true;
                                });
                                // mailController.text=emailF;
                                // passwordController.text=passwordF;
                                var data = {
                                  'email' : emailF,//mailController.text,
                                  'password' : passwordF,//passwordController.text
                                };
                                login();
                              },
                              color: Colors.red,
                              child: Text("Login", style:
                              TextStyle(fontSize: 18, color: Colors.white, fontFamily: "PTSans" )),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 55,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0),
                                ),
                                side: BorderSide(color: Colors.red),
                              ),
                              onPressed: () {
                                //print(mailController);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()),
                                );
                              },
                              color: Colors.white,
                              child: Text("Signup", style:
                              TextStyle(fontSize: 18, color: Colors.red, fontFamily: "PTSans" )),
                            ),
                          ),
                        ),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 55,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0),
                                ),
                               // side: BorderSide(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              },
                              color: Colors.white,
                              child: Text("Guest Login", style:
                              TextStyle(fontSize: 18, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w300 )),
                            ),
                          ),
                        ),
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
    );


  }

Expanded buildDivider(){
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
      height: 1.5,
      ),);
}

  _showMsg(msg) { //
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

  void login() async{

    setState(() {
      _isLoading = true;
    });


    var data = {
      'email' : mailController.text,
      'password' : passwordController.text
    };

    EasyLoading.show(status: 'loading...');
    var res = await CallApi().postData(data, '/mobileLogin');
    var body = json.decode(res.body);
    EasyLoading.dismiss();
    //print(body);
    if(body['success']!){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => HomePage()));
    }else{
      _showMsg(body['message']);
      //EasyLoading.showToast(body['message']);
    }

    setState(() {
      _isLoading = false;
    });




  }
}