import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Screens/Orders/orderListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
          ),
          centerTitle: true,
          title: Text("Orders History",
            style: TextStyle(
                fontSize: 23,
                color: Colors.red,
                fontFamily: "PTSans",
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.red,
            tabs: [
              Tab(text: "In Process",),
              Tab(text: "Completed",),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrderInQueue(),
            Center(child: Icon(Icons.add_shopping_cart_outlined)),
          ],
        ),
      ),
      length: 2,
    );
  }
}
