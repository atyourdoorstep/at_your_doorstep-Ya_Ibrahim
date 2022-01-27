import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Screens/LandingPages/showItemPage.dart';
import 'package:at_your_doorstep/Screens/Orders/orderDetailPage.dart';
import 'package:at_your_doorstep/Screens/SellerControl/notifiedOrders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class OrderDetailsForSeller extends StatefulWidget {
  final OrdersItem;
  final userDetails;
  final ordersIdList;
  final paymentDetail;
  OrderDetailsForSeller({this.paymentDetail,this.OrdersItem,this.userDetails,this.ordersIdList});


  @override
  _OrderDetailsForSellerState createState() => _OrderDetailsForSellerState();
}

class _OrderDetailsForSellerState extends State<OrderDetailsForSeller> {

  var ordersItem;
  var userDetails;
  var ordersIdList;
  var paymentDetail;

  @override
  void initState() {
    ordersItem = widget.OrdersItem;
   userDetails = widget.userDetails;
    ordersIdList = widget.ordersIdList;
    paymentDetail = widget.paymentDetail;

    // if(ordersItem['payment']!= null){
    //   print(ordersItem['payment']);
    // }
    // print(ordersItem[0]['orders'][0]['id']);
    // print(ordersItem[0]['orders'][0]['order_items'][0]['id']);

    super.initState();
  }

  String dropdownValue = 'Processing';
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
            ///
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color:  Colors.red,),
                            borderRadius:  BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Text(" ${ucFirst(paymentDetail['type'])} ", style:
                          TextStyle(fontSize: 14, color:  Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , )),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange,),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Text(" ${ucFirst(paymentDetail['status'])} ", style:
                          TextStyle(fontSize: 14, color: Colors.orange, fontFamily: "PTSans", fontWeight: FontWeight.w700 , )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Text(" ${paymentDetail['stripe_payment_id']} ", style:
                    TextStyle(fontSize: 14, color: Colors.grey, fontFamily: "PTSans", fontWeight: FontWeight.w700 , )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Order ID #${paymentDetail['order_id']}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w700),),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Date: ", style:
                    TextStyle(fontSize: 13, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                    Text(paymentDetail['created_at'].substring(0,10), style:
                    TextStyle(fontSize: 13, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                  ],
                ),
              ),
            ),
            ///
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Order Details: ", style:
              TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: ordersItem.length <= 1 ? 150 :500,
              child: ordersItem.length >= 1 ? ListView.builder(
                itemCount: ordersItem.length,
                itemBuilder:(context , index){
                  return GestureDetector(
                    onTap: (){
                      showMsg(context, "Rs. ${ordersItem[index]['item']['price']} , Quantity(s): ${ordersItem[index]['quantity']}");
                      showModalBottomSheet(
                        elevation: 20.0,
                        context: context,

                        builder: (context) => Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text("SET ORDER STATUS!", style:
                              TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text("Select Change Status: "),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: DropdownButton(
                                      focusColor: Colors.white,
                                      value: dropdownValue,
                                      underline: Container(
                                        height: 2,
                                        color: Colors.white,
                                      ),
                                      iconEnabledColor: Colors.black,
                                      style: const TextStyle(color: Colors.red),
                                      onChanged: (String? newValue){
                                        setState(() {
                                          dropdownValue = newValue!;
                                          //ispublic = dropdownValue == 'Public'? 1 : 0;
                                        });
                                        //print(ispublic);
                                      },
                                      items: <String>['Processing', 'Delivered','Completed','Canceled']
                                          .map<DropdownMenuItem<String>>((String value){
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(value),
                                          ),
                                        );
                                      }
                                      ).toList(),
                                    ),
                                  ),
                                ],//['Processing', 'Delivered','Completed','Canceled']
                              ),
                            ),
                            AYDButton(
                              onPressed: ()async{
                                var res= await CallApi().postData({
                                  'status':dropdownValue,
                                  'order_item_id': ordersItem[index]['id'],
                                  'order_id': ordersItem[index]['order_id'],
                                  'seller':ordersItem[index]['seller_id']
                                },'/changeStatus');
                                var body =json.decode(res.body);
                                if(res.statusCode == 200){
                                  print(body.toString());
                                  showMsg(context, "Order Confirmed!!");

                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.of(
                                    context,
                                    rootNavigator: true,).push(MaterialPageRoute(builder: (context)=>NotifiedOrdersList()));

                                }
                              },
                              buttonText: "Done",
                            ),
                          ],
                        ),
                      );

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
                                      child: Text("Actual Rs. ${ordersItem[index]['item']['price']}", style: TextStyle(
                                        color: Colors.blue,
                                      ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text("Discount Rs. ${ordersItem[index]['discount']}", style: TextStyle(
                                        color: Colors.blue,
                                      ),),
                                    ),
                                    SizedBox(height: 3),
                                    ordersItem[index]['discount'] >0 ? Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text("Discounted Rs. ${(ordersItem[index]['item']['price']*ordersItem[index]['quantity'])-ordersItem[index]['discount']}", style: TextStyle(
                                            color: Colors.blue,
                                          ),),
                                        ),
                                        Text("${ordersItem[index]['item']['price']*ordersItem[index]['quantity']}",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            decoration: TextDecoration.lineThrough,
                                          ),),
                                      ],
                                    ): SizedBox(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: ordersItem[index]['item']['type'] == 'product' ? Text("Quantity(s): "+ordersItem[index]['quantity'].toString(), style: TextStyle(
                                        color: Colors.blue,
                                      ),): Text("Service is Booked ", style: TextStyle(
                                        color: Colors.blue,
                                      ),),
                                    ),
                                  ],
                                ),
                                trailing:  Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ordersItem[index]['status'] == "processing" ? Chip(
                                    shape: StadiumBorder(side: BorderSide(color: Color(0xffD60024), width: 2)),
                                    label:Text(ucFirst(ordersItem[index]['status']),
                                      style: TextStyle(
                                        color: Color(0xffD60024),fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    backgroundColor: Color(0xFFFFE7E7) ,
                                  ): Chip(
                                    shape: StadiumBorder(side: BorderSide(color: Color(0xff0060F0), width: 2)),
                                    label:Text(ucFirst(ordersItem[index]['status']),
                                      style: TextStyle(
                                        color: Color(0xff0060F0),fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    backgroundColor: Color(0xFFE2EDFF) ,
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
            ordersItem[0]['status'] == "confirmed" ?SizedBox(): Align(
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

                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.of(
                            context,
                            rootNavigator: true,).push(MaterialPageRoute(builder: (context)=>NotifiedOrdersList()));

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
