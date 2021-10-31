import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/LandingPages/showItemPage.dart';
import 'package:at_your_doorstep/Screens/Orders/orderDetailPage.dart';
import 'package:at_your_doorstep/Screens/Orders/sellerOrderDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CheckoutPage extends StatefulWidget {
  final stripToken;
  final ordersList;
  final itemsDetails;

  CheckoutPage({this.ordersList,this.stripToken, this.itemsDetails});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  var stripToken;
  var ordersList;
  var itemsDetails;

  @override
  void initState() {
    stripToken = widget.stripToken;
    ordersList = widget.ordersList;
    itemsDetails = widget.itemsDetails;
    print(itemsDetails);
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
          icon: Icon(Icons.close, color: Colors.red,size: 35,),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('${ucFirst((userD['fName'].toString()))} ${ucFirst((userD['lName'].toString()))}', style:
                TextStyle(fontSize: 15, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.bold)),
                Text('Deliver to: ${ucFirst((userD['address'].toString()))}', style:
                TextStyle(fontSize: 12, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 7),
            Text("Order Details"),
            SizedBox(
              height: itemsDetails.length == 1 ? 140 : 270,
              child: ListView.builder(
                itemCount:  itemsDetails.length,
                itemBuilder:(context , index){
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0,1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        //border: Border.all(color: Colors.red),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 60,
                                minHeight: 80,
                                maxHeight: 140,
                                maxWidth: 120,
                              ),
                              child: Image.network( itemsDetails[index]['image'], fit: BoxFit.cover,)),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(ucFirst( itemsDetails[index]['name']),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w700),),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              child: Text("Rs. "+ itemsDetails[index]['price'].toString(), style: TextStyle(
                                color: Colors.blue,
                              ),),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );//categoryItem[index]['image']
                },
              ),
            ),
            ////
            AYDButton(
              buttonText: "Place Order!",
              onPressed: () async {
                EasyLoading.show(status: 'Creating Order...');
                var res= await CallApi().postData({
                  'items': ordersList,
                  'stripe_token': stripToken,
                  'cur': "PKR",
                },'/orderCreate');
                var body =json.decode(res.body);
                EasyLoading.dismiss();
                if(res.statusCode == 200){
                  showMsg(context,"Order Created Successfully!!");
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Order Created Successfully ", style:
                          TextStyle(fontSize: 15, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                          title: Column(
                            children: [
                              Image.asset("assets/atyourdoorstep.png",
                                height: 40,
                                width: 40,
                              ),
                              SizedBox(height: 5,),
                              Text("Order!"),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                for(int i=0;i<ordersList.length ;i++){
                                                            var res= await CallApi().postData({
                                                              'id': ordersList[i]['item_id'],
                                                            },'/removeFromCart');
                                                          }
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text("Close"),
                            ),
                          ],
                        );
                      });
                  /////
                }
                else{
                  showMsg(context,"There is some issues");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
