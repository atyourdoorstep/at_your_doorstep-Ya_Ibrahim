import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Screens/LandingPages/showItemPage.dart';
import 'package:at_your_doorstep/Screens/Orders/orderDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class OrderDetailsForSeller extends StatefulWidget {
  final OrdersItem;
  final userDetails;
  final ordersIdList;
  OrderDetailsForSeller({this.OrdersItem,this.userDetails,this.ordersIdList});


  @override
  _OrderDetailsForSellerState createState() => _OrderDetailsForSellerState();
}

class _OrderDetailsForSellerState extends State<OrderDetailsForSeller> {

  var ordersItem;
  var userDetails;
  var ordersIdList;

  @override
  void initState() {
    ordersItem = widget.OrdersItem;
   userDetails = widget.userDetails;
    ordersIdList = widget.ordersIdList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Order Details",
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.red,
                    fontFamily: "PTSans",
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0),
              ),
            ),
            Text("Ordered Date: ", style:
            TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
            Text(ordersItem[0]['created_at'].substring(0,10), style:
            TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Buyer Personal Info: ", style:
              TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Full Name:  ${ucFirst(userDetails['fName'])} ${ucFirst(userDetails['lName'])}", style:
                  TextStyle(fontSize: 15, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                  Text("Address:  ${userDetails['address'] == "" ? "Not Available" : userDetails['address']}", style:
                  TextStyle(fontSize: 15, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                  Text("Contact No:  ${userDetails['contact']}", style:
                  TextStyle(fontSize: 15, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                  Text("Email Address:  ${userDetails['email']}", style:
                  TextStyle(fontSize: 15, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Order Details: ", style:
              TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: ordersItem.length <= 1 ? 150 :400,
              child: ordersItem.length >= 1 ? ListView.builder(
                itemCount: ordersItem.length,
                itemBuilder:(context , index){
                  return GestureDetector(
                    onTap: (){
                      showMsg(context, "Rs. ${ordersItem[index]['item']['price']} , Quantity(s): ${ordersItem[index]['quantity']} , id : ${ordersItem[index]['id']}");
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Center(
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(ucFirst(ordersItem[index]['item']['name']),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w700),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text("Rs. "+ordersItem[index]['item']['price'].toString(), style: TextStyle(
                                        color: Colors.blue,
                                      ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text("Quantity(s): "+ordersItem[index]['quantity'].toString(), style: TextStyle(
                                        color: Colors.blue,
                                      ),),
                                    ),
                                  ],
                                ),
                                trailing:  Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Chip(
                                    shape: StadiumBorder(side: BorderSide(color: Color(0xffD60024), width: 2)),
                                    label:Text(ucFirst(ordersItem[index]['status']),
                                      style: TextStyle(
                                        color: Color(0xffD60024),fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    backgroundColor: Color(0xFFFFE7E7) ,
                                  ),
                                ),
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
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    AYDButton(onPressed: ()async{
                      EasyLoading.show(status: 'loading...');
                        var res= await CallApi().postData({
                          'seller_id': sellerID,
                          'user_id': userDetails['id'],
                          'order_items': ordersIdList,
                        },'/createInvoice');
                        var body =json.decode(res.body);
                        EasyLoading.dismiss();
                        if(res.statusCode == 200){
                          print(body.toString());
                          showMsg(context, "Order Confirmed!!");
                        }
                    },
                      buttonText: "Confirm Order!",
                    ),
                    AYDOutlinedButton(onPressed: (){},buttonText: "Cancel",)
                  ],
                ),
              ),),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
