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
import 'package:at_your_doorstep/Screens/getAddressFromCustomer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PaymentPage extends StatefulWidget {
  final ordersList;
  final itemsDetails;

  PaymentPage({this.ordersList, this.itemsDetails});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  TextEditingController cardNoController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  TextEditingController expYearController = TextEditingController();
  TextEditingController expMonthController = TextEditingController();
  var ordersList;
  var itemsDetails;
  var stripToken;
  var currentAddress1;
  bool executed = false;

  @override
  void initState() {
    executed = false;
    getCurrentUserInfo2();
    ordersList = widget.ordersList;
    itemsDetails = widget.itemsDetails;
    print(ordersList.toString());
    print(currentAddress1);
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
          icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
        ),
      ),
      body: executed ? Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("AT YOUR DOORSTEP", style:
              TextStyle(fontSize: 20, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
            ),
            Center(
              child: Text("PAYMENT", style:
              TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
            ),
            SizedBox(
              height: 20,
            ),
            textfieldStyle(
              maxLength: 16,
              textHint: 'Enter Card Number', obscureText: false, textLabel1: 'Card Number ',controllerText: cardNoController,keyBoardType: TextInputType.number,
                inputAction: TextInputAction.next,
                suffixButton: IconButton(
                  iconSize: 30,
                  icon: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPuTRAL7PGHvmRST1EZ1uXBxnTn_mG0xL2cinsZmjd_VrOUf-Xydx2t0l9&s=10"), onPressed: () {  },
                ),
            ),
            Row(
              children: [
                Expanded(child: textfieldStyle(maxLength: 2,textHint: 'Expiry Month', obscureText: false, textLabel1: 'Expiry Month ',controllerText: expMonthController,keyBoardType: TextInputType.number,inputAction: TextInputAction.next)),
                Expanded(child: textfieldStyle(maxLength: 4,textHint: 'Expiry Year', obscureText: false, textLabel1: 'Expiry Year',controllerText: expYearController, inputAction: TextInputAction.next, keyBoardType: TextInputType.number)),
              ],
            ),
            textfieldStyle(maxLength: 3,textHint: 'CVV', obscureText: false, textLabel1: 'CVV ',controllerText: cvcController,keyBoardType: TextInputType.number,inputAction: TextInputAction.done),
            AYDButton(
              buttonText: "Pay now",
              onPressed: (){
                getStripeToken({
                  'number': cardNoController.text,
                  'exp_month': expMonthController.text,
                  'cvc': cvcController.text,
                  'exp_year': expYearController.text,
                });
              },
            )
          ],
        ),
      ): SpecialSpinner(),
    );
  }

  getStripeToken(var data) async {
    stripToken={};
    EasyLoading.show(status: 'Generating Token...');
    var res= await CallApi().postData(data,'/getStripToken');
    var body =json.decode(res.body);
    EasyLoading.dismiss();
    if(res.statusCode == 200){
      setState(() {
        stripToken = body;
      });
      print(stripToken['token']['id'].toString());

      // Navigator.push(context, new MaterialPageRoute(
      //     builder: (context) =>CheckoutPage(stripToken: stripToken['token']['id'],ordersList: ordersList, itemsDetails: itemsDetails,)));

      if(currentAddress1 == null){
         Navigator.push(context, new MaterialPageRoute(
             builder: (context) =>AskingForAddressOrderTime(striprToken: stripToken['token']['id'],ordersList: ordersList,itemsDetails: itemsDetails,)));
       }
       else{
         Navigator.push(context, new MaterialPageRoute(
             builder: (context) =>CheckoutPage(stripToken: stripToken['token']['id'],ordersList: ordersList, itemsDetails: itemsDetails,)));
       }
    }
    if(body['success']== false){
      showMsg(context, body['message']);
    }
  }

  getCurrentUserInfo2()async {
    currentAddress1 ="";
    var res= await CallApi().postData({},'/getCurrentUser');
    var body =json.decode(res.body);
    EasyLoading.dismiss();
    if(res.statusCode == 200){
      setState(() {
        currentAddress1 = body['user']['address'];
      });
      executed = true;
      print(currentAddress1);
    }
  }

}
