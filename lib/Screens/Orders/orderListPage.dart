import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Screens/LandingPages/showItemPage.dart';
import 'package:at_your_doorstep/Screens/Orders/orderDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderInQueue extends StatefulWidget {
  const OrderInQueue({Key? key}) : super(key: key);

  @override
  _OrderInQueueState createState() => _OrderInQueueState();
}

class _OrderInQueueState extends State<OrderInQueue> {

  late bool executed;
  late var orderItems;

  @override
  void initState() {
    executed = false;
    getOrderedItems();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: executed ? SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
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
                              subtitle: Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  children: List<Widget>.generate(orderItems[index]['order_items'].length,
                                          (int orderIn){
                                    var item= orderItems[index]['order_items'];
                                        return
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Chip(
                                              shape: StadiumBorder(side: BorderSide(color: Color(0xffD60024), width: 2)),
                                              label:Column(
                                                children: [
                                                  InkResponse(
                                                    onTap:(){
                                                      Navigator.push(
                                                          context,
                                                          new MaterialPageRoute(
                                                              builder: (context) => ShowItemPage(itemDetails: item[orderIn]['item'])));
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(ucFirst(item[orderIn]['item']['name']),
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: Color(0xffD60024),fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text("(${ucFirst(item[orderIn]['status'])})",
                                                    style: TextStyle(
                                                      color: Colors.red,fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              backgroundColor: Color(0xFFFFE7E7) ,
                                            ),
                                          );
                                      }
                                  ).toList(),
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails()),);
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
                // )//:ListTile(title: Center(child: Text("No Order Place Yet!",
                //   style: TextStyle(color: Colors.red),
                // )),
              )
              ),
            ],
          ),
        ),
      ): SpecialSpinner(),
    );
  }
  getOrderedItems() async {
    orderItems={};
    var res= await CallApi().postData({},'/getOrders');
    var body =json.decode(res.body);
    if(res.statusCode == 200){
      setState(() {
        orderItems = body['orders'];
      });
      print(orderItems.toString());
      executed = true;
    }
  }
}
