import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/registerForSeller.dart';
import 'package:at_your_doorstep/Screens/requestNewService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class UpdateSellerProfile extends StatefulWidget {
  const UpdateSellerProfile({Key? key}) : super(key: key);

  @override
  _UpdateSellerProfileState createState() => _UpdateSellerProfileState();
}

class _UpdateSellerProfileState extends State<UpdateSellerProfile> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  bool _isChanged=false;
  late Map<String,dynamic> userDataSeller;
bool excuted = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    userDataSeller=userSeller;
    print("hello $userDataSeller");
    titleController.text=ucFirst(userDataSeller['title'].toString());
    print(userDataSeller['title'].toString());
    descriptionController.text=ucFirst(userDataSeller['description'].toString());
    urlController.text= userDataSeller['url'].toString();
  }
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
                          height: 30,
                        ),
                        Center(
                          child: Text("UPDATE PROFILE", style:
                          TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        textfieldStyle(textHint: ucFirst(userDataSeller['title'].toString()), obscureText: false, textLabel1:'Title', controllerText: titleController, onChange: (value){setState(() {_isChanged=true;}); },),
                        textfieldStyle(textHint:ucFirst(userDataSeller['description'].toString()) , obscureText: false, textLabel1: 'Describe your service', controllerText: descriptionController,onChange:(value) {setState(() {_isChanged=true;}); },),
                        textfieldStyle(textHint: userDataSeller['url'].toString(), obscureText: false, textLabel1: 'Email',controllerText: urlController,onChange:(value) {setState(() {_isChanged=true;}); },),
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
                                onPressed: _isChanged?()=>{ _storeSellerInfo({
                                  'token': token,
                                  'title':titleController.text.toLowerCase(),
                                  'description':descriptionController.text.toLowerCase(),
                                  'url':urlController.text.toLowerCase(),
                                }
                                )}:null,
                                color: Colors.red,
                                child: Text("Save", style:
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
  toLocal(String key,String val)async
  {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(key, val);
  }
  _storeSellerInfo(var data ) async {
    EasyLoading.show(status: 'loading...');
    var res = await CallApi().postData(data, '/updateProfile');
    var body = json.decode(res.body);
    EasyLoading.dismiss();
    print(body);
    if(res.statusCode == 200) {
      if (body != null) {
        if (body['success']!) {
          print(body.toString());
          toLocal('userSeller', json.encode(body['profile']));
          SharedPreferences localStorage = await SharedPreferences
              .getInstance();
          var userJson = localStorage.getString('userSeller');
          var user = json.decode(userJson!);
          setState(() {
            userSeller = user;
            _isChanged = false;
          });
        }
        showMsg(context, body['message']);
      }
      excuted = true;
    }
  }

}