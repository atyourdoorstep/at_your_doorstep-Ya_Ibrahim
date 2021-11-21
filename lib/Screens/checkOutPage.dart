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
import 'package:at_your_doorstep/Screens/getAddressFromCustomer.dart';
import 'package:at_your_doorstep/orderCompletePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  bool executed = false;
  TextEditingController dCodeController = TextEditingController();

  @override
  void initState() {
    executed = false;
    getCurrentUserInfo();
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
      body: executed ? SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text('${ucFirst((userD['fName'].toString()))} ${ucFirst((userD['lName'].toString()))}', style:
                  TextStyle(fontSize: 18, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Deliver to: ${currentAddress}', style:
                        TextStyle(fontSize: 13, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.bold)),
                      ),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context, new MaterialPageRoute(
                            builder: (context) =>AskingForAddressOrderTime(
                              striprToken: stripToken,
                              ordersList: ordersList,
                              itemsDetails: itemsDetails,
                            )));

                      },
                          child: Icon(Icons.edit)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Order Details", style: TextStyle(fontWeight: FontWeight.w600 , ),),
              ),
              SizedBox(
                height: itemsDetails.length == 1 ? 140 : 300,
                child: ListView.builder(
                  itemCount:  itemsDetails.length,
                  itemBuilder:(context , index){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        height: 100,
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
                            subtitle:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Quantity ${ordersList[index]['quantity']}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black26, fontSize: 12.0, fontWeight: FontWeight.w700 ),),
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

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText:  ' Enter Your Discount code',
                          suffixIcon:  Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ElevatedButton(
                                onPressed: (){
                              print(dCodeController.text);
                            }, child: Text("Apply Code")),
                          ),
                        ),
                        obscureText: false,
                        controller: dCodeController,
                        onSubmitted: (value){
                          print(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              AYDButton(
                buttonText: "Checkout!",
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
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>OrderComplete(orderList: ordersList,)));

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
      ): SpecialSpinner(),
    );
  }
// currentAddress = body['user']['address'];
  //var res = await CallApi().postData({}, '/getCurrentUser');
  getCurrentUserInfo()async {
    currentAddress ="";
    var res= await CallApi().postData({},'/getCurrentUser');
    var body =json.decode(res.body);
    if(res.statusCode == 200){
      setState(() {
        currentAddress = body['user']['address'];
      });
      executed = true;
      print(currentAddress);
    }
  }

}
