import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

class SuggestNewService extends StatefulWidget {
  const SuggestNewService({Key? key}) : super(key: key);

  @override
  _SuggestNewServiceState createState() => _SuggestNewServiceState();
}

class _SuggestNewServiceState extends State<SuggestNewService> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController desNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    mailController.text= userD['email'].toString();
    firstNameController.text= userD['fName'].toString();
    super.initState();
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
                        textfieldStyle(textHint:"Name", obscureText: false, textLabel1:'Your Name',controllerText: firstNameController,),
                        textfieldStyle(textHint: "Email", obscureText: false, textLabel1: 'Email',controllerText: mailController,),
                        textfieldStyle(
                          contentP:   EdgeInsets.symmetric(vertical: 50),
                          textHint: "Write your Request", obscureText: false, textLabel1: 'Request Message',controllerText: desNameController,),
                        AYDButton(
                          buttonText: "Send",
                          onPressed: () async {
                            SharedPreferences localStorage = await SharedPreferences.getInstance();
                            if(desNameController.text !=""){
                              saveRequest({
                                'token': localStorage.getString('token'),
                                'description': desNameController.text,
                              });
                            }
                          },
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
  saveRequest(var data ) async {
    EasyLoading.show(status: 'loading...');
    var res = await CallApi().postData(data, '/requestService');
    var body = json.decode(res.body);
    EasyLoading.dismiss();
    print(body);
    if (body != null){
      if (body['success']!) {
        print(body.toString());
        showMsg(context,"Request Sent Successfully");
      }
      showMsg(context,body['message']);
    }
  }

}
