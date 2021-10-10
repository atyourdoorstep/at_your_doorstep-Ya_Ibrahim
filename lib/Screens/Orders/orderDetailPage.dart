import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  final ordersDetails;
  final orderNo;
  OrderDetails({this.ordersDetails, this.orderNo});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  var ordersDetails;
  var orderNo;
  @override
  void initState() {
    ordersDetails = widget.ordersDetails;
    orderNo = widget.orderNo;
    print(ordersDetails.length);
    super.initState();
  }

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
        title: Text(orderNo,
          style: TextStyle(
              fontSize: 23,
              color: Colors.red,
              fontFamily: "PTSans",
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0),
        ),
        backgroundColor: Colors.white,

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ordersDetails.length <= 1 ? 150 :400,
              child: ordersDetails.length >= 1 ? ListView.builder(
                itemCount: ordersDetails.length,
                itemBuilder:(context , index){
                  return GestureDetector(
                    onTap: (){
                      showMsg(context, "Rs. ${ordersDetails[index]['item']['price']} , Quantity(s): ${ordersDetails[index]['quantity']}");
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
                                    child: Text(ucFirst(ordersDetails[index]['item']['name']),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w700),),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text("Rs. "+ordersDetails[index]['item']['price'].toString(), style: TextStyle(
                                      color: Colors.blue,
                                    ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text("Quantity(s): "+ordersDetails[index]['quantity'].toString(), style: TextStyle(
                                      color: Colors.blue,
                                    ),),
                                  ),
                                ],
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
              ):Center(
                child: ListTile(title: Center(child: Text("Cart is Empty !!",
                  style: TextStyle(color: Colors.red),
                )),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
