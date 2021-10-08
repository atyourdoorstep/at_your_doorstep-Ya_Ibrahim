import 'dart:convert';

import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class RegisterSellerOne extends StatefulWidget {
  const RegisterSellerOne({Key? key}) : super(key: key);

  @override
  _RegisterSellerOneState createState() => _RegisterSellerOneState();
}

class _RegisterSellerOneState extends State<RegisterSellerOne> {

  String dropdownValue = 'Home';
  int idCat = 0;
  TextEditingController userNameController = TextEditingController();

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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text("REGISTER YOURSELF AS A", style:
              TextStyle(fontSize: 16, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w500 , letterSpacing: 2.0)),
            ),
            Center(
              child: Text("SERVICE PROVIDER", style:
              TextStyle(fontSize: 23, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
            ),
            SizedBox(
              height: 30.0,
            ),
            textfieldStyle(textHint: "Username", obscureText: false, textLabel1:'Username', controllerText: userNameController),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Select the type of Service:", style:
                TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w400)),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Card(
                 color: Colors.white,
                  //padding: EdgeInsets.all(0.0),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    focusColor: Colors.white,
                    value: dropdownValue,
                    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                    iconEnabledColor: Colors.black,
                    style: const TextStyle(color: Colors.red),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        if(dropdownValue== 'Home')
                          idCat=1;
                        else if(dropdownValue== 'Electronics')
                          idCat=2;
                        else if(dropdownValue== 'Medical & Pharma')
                          idCat=3;
                        else
                          idCat=8;

                        print(idCat);
                      });
                    },
                    items: <String>['Home', 'Electronics', 'Medical & Pharma', 'Education']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    hint: Text("Please select the service type"),
                  ),
                ),
              ),
            ),
            ///
            Padding(
              padding: EdgeInsets.all(12.0),
              child: AYDButton(
                buttonText: "Register",
                onPressed: () {
                  if(userNameController.text != ""){
                    _registerServicePro();
                  }
                  else {
                    showMsg(context, "Your Username field box is Empty!!");
                  }
                },
              ),
            ),
            ///
          ],
        ),
      ),
    );
  }

  void _registerServicePro()async{
    var data = {
      'user_name' : userNameController.text,
      'category_id' : idCat,
    };
    var resp;
    resp= await CallApi().postData(data, '/registerSeller');
    var body = json.decode(resp.body);
    print(body.toString());
    if(body['success']){
      showMsg(context, "You have Successfully Register as a Service Provider.");
      Navigator.pop(context);
      getRoleUser();
       String role = "";
      EasyLoading.show(status: 'Setting up Your Seller Profile...');
      var res= await CallApi().postData({},'/getRole' );
      var body =json.decode(res.body);
      if(res.statusCode == 200){
        role= body['roleName'];
        setState(() {
          roleOfUser = role;
        });
        if(role.toString() == "seller"){
          EasyLoading.dismiss();
        }
      }
    }
    else{
      showMsg(context,body['message']);
    }
  }

}
