import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/Cart/cartPage.dart';
import 'package:at_your_doorstep/Screens/LandingPages/showItemPage.dart';
import 'package:at_your_doorstep/Screens/Orders/orderDetailPage.dart';
import 'package:at_your_doorstep/Screens/Orders/sellerOrderDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class OrderComplete extends StatefulWidget {
  final orderList;
  OrderComplete({this.orderList});

  @override
  _OrderCompleteState createState() => _OrderCompleteState();
}

class _OrderCompleteState extends State<OrderComplete> {

  var orderList;

  @override
  void initState() {
    orderList = widget.orderList;
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
          onPressed: () async {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            for(int i=0;i<orderList.length ;i++){
                                        var res= await CallApi().postData({
                                          'id': orderList[i]['item_id'],
                                        },'/removeFromCart');
                                        var body =json.decode(res.body);
                                        print(body.toString());
                                      }
          },
          icon: Icon(Icons.close, color: Colors.red,size: 35,),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/atyourdoorstep.png",
                height: 60,
                width: 60,
              ),
              SizedBox(height: 7,),
              Text("Order!"),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Order Created Successfully ", style:
                TextStyle(fontSize: 16, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
