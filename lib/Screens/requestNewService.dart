import 'dart:async';
import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
        ),
      ),
      // body: Container(
      //   child: Text(userD['email'].toString()),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:  Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Text("REQUEST FOR NEW SERVICE", style:
                          TextStyle(fontSize: 25, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        textfieldStyle(textHint:"Name", obscureText: false, textLabel1:'Your Name',),
                        textfieldStyle(textHint: "Email", obscureText: false, textLabel1: 'Email',),
                        textfieldStyle(contentP: EdgeInsets.symmetric(vertical: 60) ,textHint: "Write your Message", obscureText: false, textLabel1: 'Request Message',),
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
                                  SharedPreferences localStorage = await SharedPreferences.getInstance();
                                  // String? token=localStorage.getString('token');
                                  XFile x=await _imgFromGallery();
                                  var resp=await CallApi().uploadFile(x,
                                      {
                                       'token':localStorage.getString('token'),
                                        'name':'newName',
                                        'description':'desc',
                                        'category_id':6,
                                        'price':222,
                                      }
                                      , '/createPost');
                                  print('response: '+resp.toString());
                                  var body = resp.data;
                                  if(body['success'])
                                    {
                                      print(body.toString());
                                    }
                                  else
                                    showMsg(context, body['message']);
                                },
                                color: Colors.red,
                                child: Text("Send", style:
                                TextStyle(fontSize: 18, color: Colors.white, fontFamily: "PTSans" )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
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
  _imgFromGallery() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    final ImagePicker _picker = ImagePicker();
    XFile image = await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ) as XFile;
    return image;
  }
}
