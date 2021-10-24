import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Screens/LandingPages/showItemPage.dart';
import 'package:at_your_doorstep/Screens/Orders/orderDetailPage.dart';
import 'package:at_your_doorstep/Screens/Orders/sellerOrderDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotifiedOrdersList extends StatefulWidget {
  const NotifiedOrdersList({Key? key}) : super(key: key);

  @override
  _NotifiedOrdersListState createState() => _NotifiedOrdersListState();
}

class _NotifiedOrdersListState extends State<NotifiedOrdersList>
    with SingleTickerProviderStateMixin{

  var orderItems1;
  bool executed3 = false;
  var today = new DateTime.now();
  var date = '';
  //late AnimationController _animationController;
  //List<Map<String ,Object>> order_items = [];
  List<int> order_items = [];

  @override
  void initState() {
    executed3 = false;
    date = today.toString().substring(0,10);
   // _animationController = new AnimationController(vsync: this , duration: Duration(seconds: 1));
   // _animationController.repeat(reverse: true);
    getOrderedItemsSeller();
    super.initState();
  }

  @override
  void dispose() {
   // _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Notification",
          style: TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontFamily: "PTSans",
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
        ),
      ),
      body: executed3 ? SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              orderItems1.length > 0 ? SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: orderItems1.length,
                  itemBuilder:(context , index){
                    return GestureDetector(
                      onTap: (){
                        // order_items.clear();
                        // var orders = orderItems1[index]['orders'][0]['order_items'];
                        // print(orders.length);
                        // for(int i=0;i< orders.length ; i++){
                        //   order_items.insert(i, orders[i]['id']);
                        // }
                        // print(order_items);

                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            OrdersListSellerSide(orderItems: orderItems1[index]['orders'],)),);

                        // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        //     OrderDetailsForSeller(
                        //       OrdersItem: orderItems1[index]['orders'][0]['order_items'],
                        //       userDetails: orderItems1[index],
                        //       ordersIdList: order_items,
                        //       )),);
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // date == orderItems1[index]['orders'][0]['created_at'].substring(0,10) ? FadeTransition(
                                    //   opacity: _animationController,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    //     child: Container(
                                    //       color: Colors.red,
                                    //       child: Text(" New ", style:
                                    //       TextStyle(fontSize: 14, color: Colors.white, fontFamily: "PTSans", fontWeight: FontWeight.w700 , )),
                                    //     ),
                                    //   ),
                                    // ): SizedBox(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${ucFirst(orderItems1[index]['fName'])} ${ucFirst(orderItems1[index]['lName'])}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.w700),),
                                    ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Customer ID: ", style:
                                      TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                                      Text("${orderItems1[index]['id']}", style:
                                      TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                                    ],
                                  ),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text("No of Orders: ${orderItems1[index]['orders'].length}", style:
                                  TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ): ListTile(title: Center(child: Text("No Order Notification!",
                style: TextStyle(color: Colors.red),
              ))),
            ],
          ),
        ),
      ): SpecialSpinner(),
    );
  }
  getOrderedItemsSeller() async {
   orderItems1={};
    var res= await CallApi().postData({'check':1},'/getOrders');
    var body =json.decode(res.body);
    print(body[0].toString());
    if(res.statusCode == 200){
      setState(() {
       orderItems1 = body[0];
      });
      orderItems1 = orderItems1.reversed.toList();
      print(orderItems1.toString());
      executed3 = true;
    }
  }
}

class OrdersListSellerSide extends StatefulWidget {
  final orderItems;
  OrdersListSellerSide({this.orderItems});

  @override
  _OrdersListSellerSideState createState() => _OrdersListSellerSideState();
}

class _OrdersListSellerSideState extends State<OrdersListSellerSide> {
  var orderItems;

  @override
  void initState() {
    orderItems = widget.orderItems;
    orderItems = orderItems.reversed.toList();
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
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: orderItems.length,
                itemBuilder:(context , index){
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Order #${index+1}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.w700),),
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Ordered Date: ", style:
                                  TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                                  Text(orderItems[index]['order_items'][0]['created_at'].substring(0,10), style:
                                  TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                                ],
                              ),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(onPressed: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                //     OrderDetails(orderNo: "Order #${index+1}",
                                //       ordersDetails: orderItems[index]['order_items'],
                                //     )),);
                              },
                                  child: Text("Order Details")),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
