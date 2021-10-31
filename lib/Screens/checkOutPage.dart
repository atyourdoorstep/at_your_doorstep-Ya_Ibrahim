import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/LandingPages/showItemPage.dart';
import 'package:at_your_doorstep/Screens/Orders/orderDetailPage.dart';
import 'package:at_your_doorstep/Screens/Orders/sellerOrderDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CheckoutPage extends StatefulWidget {
  final stripToken;
  final ordersList;
  CheckoutPage({this.ordersList,this.stripToken});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  var stripToken;
  var ordersList;

  @override
  void initState() {
    stripToken = widget.stripToken;
    ordersList = widget.ordersList;
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
      body: Container(
        child: Column(
          children: [
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello!", style:
                TextStyle(fontSize: 17, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w500 )),
                Text('${ucFirst((userD['fName'].toString()))} ${ucFirst((userD['lName'].toString()))}', style:
                TextStyle(fontSize: 26, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.bold)),
                Text('Deliver to: ${ucFirst((userD['address'].toString()))}', style:
                TextStyle(fontSize: 20, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.bold)),
              ],
            ),
            AYDButton(
              buttonText: "Place Order!",
              onPressed: () async {
                EasyLoading.show(status: 'Creating Order...');
                var res= await CallApi().postData({
                  'items': ordersList,
                  'stripe_token': stripToken,
                  'cur': "PKR",
                },'/orderCreate');
                var body =json.decode(res.body);
                EasyLoading.dismiss();
                if(res.statusCode == 200){
                  showMsg(context,"Order Created Successfully!!");
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Order Created Successfully ", style:
                          TextStyle(fontSize: 15, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                          title: Column(
                            children: [
                              Image.asset("assets/atyourdoorstep.png",
                                height: 40,
                                width: 40,
                              ),
                              SizedBox(height: 5,),
                              Text("Order!"),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text("Close"),
                            ),
                          ],
                        );
                      });
                  /////
                }
                else{
                  showMsg(context,"There is some issues");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
