import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder:(context , index){
                    return GestureDetector(
                      onTap: (){
                        //showMsg(context, "Rs. ${cartItems[index]['item']['price']} , Quantity(s): ${cartItems[index]['quantity']}");
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Order #${index}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w700),),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Rs. ", style: TextStyle(
                                            color: Colors.blue,
                                          ),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(", Quantity(s): ", style: TextStyle(
                                            color: Colors.blue,
                                          ),),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: OutlinedButton(
                                      onPressed: () {
                                      },
                                      child: Icon(Icons.delete_forever)),
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
                // )//:ListTile(title: Center(child: Text("No Order Place Yet!",
                //   style: TextStyle(color: Colors.red),
                // )),
              )
              ),
            ],
          ),
        ),
      ),
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
