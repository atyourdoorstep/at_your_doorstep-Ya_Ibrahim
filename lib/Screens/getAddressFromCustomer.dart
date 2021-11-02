import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/LandingPages/showItemPage.dart';
import 'package:at_your_doorstep/Screens/Orders/orderDetailPage.dart';
import 'package:at_your_doorstep/Screens/Orders/sellerOrderDetails.dart';
import 'package:at_your_doorstep/Screens/checkOutPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AskingForAddressOrderTime extends StatefulWidget {
  final striprToken;
  final ordersList;
  final itemsDetails;
  AskingForAddressOrderTime({this.ordersList,this.striprToken, this.itemsDetails});

  @override
  _AskingForAddressOrderTimeState createState() => _AskingForAddressOrderTimeState();
}

class _AskingForAddressOrderTimeState extends State<AskingForAddressOrderTime> {

  TextEditingController addressController = TextEditingController();
  var striprToken;
  var ordersList;
  var itemsDetails;
  bool executed = false;

  @override
  void initState() {
    executed = false;
    getCurrentUserInfo1();
    addressController.text = currentAddress.toString();
    striprToken = widget.striprToken;
    ordersList = widget.ordersList;
    itemsDetails = widget.itemsDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: Colors.red,size: 35,),
        ),
      ),
      body: executed ? SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text("ADD YOUR ADDRESS", style:
                TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
              ),
              SizedBox(
                height: 20,
              ),
              textfieldStyle(textHint: "14 Rajgarh, lahore", obscureText: false, textLabel1:'Enter Hometown Address', controllerText: addressController,),
              SizedBox(
                height: 10,
              ),
              AYDButton(
                onPressed: () async {
                  if(addressController.text.length > 5 ){
                    EasyLoading.show(status: 'Loading...');
                    var res = await CallApi().postData({'address': addressController.text.toLowerCase()}, '/updateUser');
                    var body = json.decode(res.body);
                    setState(() {
                      showMsg(context, body['message']);
                      currentAddress = body['user']['address'];
                    });
                    EasyLoading.dismiss();
                    //Navigator.pop(context);
                    Navigator.pushReplacement(context, new MaterialPageRoute(
                        builder: (context) =>CheckoutPage(
                          stripToken: striprToken,
                          ordersList: ordersList,
                          itemsDetails: itemsDetails,
                        )));

                  }
                },
                buttonText: "Add & Proceed",
              ),
            ],
          ),
        ),
      ): SpecialSpinner(),
    );
  }

  getCurrentUserInfo1()async {
    currentAddress ="";
    var res= await CallApi().postData({},'/getCurrentUser');
    var body =json.decode(res.body);
    EasyLoading.dismiss();
    if(res.statusCode == 200){
      setState(() {
        currentAddress = body['user']['address'];
        addressController.text = currentAddress;
      });
      executed = true;
      print(currentAddress);
    }
  }

}
