import 'dart:convert';
import 'dart:async';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/SellerControl/sellerProfileUpdate.dart';
import 'package:at_your_doorstep/Screens/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  TextEditingController addressController = TextEditingController();
  String addressName="";
  bool executed = false;
  late Map<String,dynamic> address = {};
@override
  void initState()  {
  executed = false;
  getSellerAddress();
  //addressController.text=address['name'].toString();
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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text("YOUR ADDRESS", style:
                TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
              ),
              SizedBox(
                height: 20,
              ),
              textfieldStyle(textHint: "14 Rajgarh, lahore", obscureText: false, textLabel1:'Enter Hometown Address', controllerText: addressController,),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: addressName == "",
                child: AYDButton(
                  onPressed: (){
                    AddSellerAddress({
                      'name': addressController.text.toString(),
                      'lat': 31.3556691,
                      'long': 74.2193974,
                    });
                  },
                  buttonText: "Add",
                ),
              ),
              Visibility(
                visible: addressName.length > 0,
                child: AYDButton(
                  onPressed: (){
                    updateSellerAddress({
                      'name': addressController.text.toString(),
                      'lat': 31.3556691,
                      'long': 74.2193974,
                    });
                  },
                  buttonText: "Update",
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  AddSellerAddress(var data) async{
    var res= await CallApi().postData(data,'/addSellerAddress' );
    var body =json.decode(res.body);
    print(  body.toString());
    if(res.statusCode == 200){
      showMsg(context, 'Address updated');
      if(sAddress == ""){
        sAddress = addressController.text;
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => editProfile()),);

      }
    }
  }
  updateSellerAddress(var data) async{
    var res= await CallApi().postData(data,'/updateSellerAddress' );
    var body =json.decode(res.body);
    print(  body.toString());
    if(res.statusCode == 200){
      print(  body.toString());
      showMsg(context, body['message']);

    }
  }
  getSellerAddress() async{
    var res= await CallApi().postData({},'/getSellersAddress' );
    var body =json.decode(res.body);
    if(res.statusCode == 200){
      print(  body.toString());
      setState(() {
        //executed = true;
        addressController.text = body['name'].toString();
        addressName = body['name'].toString();
        address=body;
      });
    }
    return body;
  }
}
