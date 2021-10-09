import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Screens/Orders/orderListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
        ),
        centerTitle: true,
        title: Text("Orders No",
          style: TextStyle(
              fontSize: 23,
              color: Colors.red,
              fontFamily: "PTSans",
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0),
        ),
        backgroundColor: Colors.white,

      ),
    );
  }
}
