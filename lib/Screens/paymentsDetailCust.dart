import 'dart:convert';

import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PaymentDetailsCustomer extends StatefulWidget {
  const PaymentDetailsCustomer({Key? key}) : super(key: key);

  @override
  _PaymentDetailsCustomerState createState() => _PaymentDetailsCustomerState();
}

class _PaymentDetailsCustomerState extends State<PaymentDetailsCustomer> {

  bool executed = false;
  late var payments;
  late var paymentD;
  bool executed1 = false;
  var borderRad = BorderRadius.all(Radius.circular(5.0));
  List amountList = [];

  @override
  void initState() {
    executed = false;
    getPaymentHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment History", style: TextStyle(fontSize: 18,
          color: Colors.red,
          fontFamily: "PTSans",
          fontWeight: FontWeight.w500,),),
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
        ),
      ),
      body: executed ? SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              payments.length > 0 ? SizedBox(
                height: 570,
                child: ListView.builder(
                  itemCount: payments.length,
                  itemBuilder:(context , index){
                    return GestureDetector(
                      onTap: (){
                        //Navigator.push(context,MaterialPageRoute(builder: (context)=>PaymentDetails(paymentID: payments[index]['stripe_payment_id'],)));
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ListTile(
                                trailing: executed1 ? Text("Rs. ${amountList[index]}") : Icon(Icons.money),
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
                                              borderRadius: borderRad,
                                            ),
                                            child: Text(" ${ucFirst(payments[index]['type'])} ", style:
                                            TextStyle(fontSize: 14, color:  Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , )),
                                          ),
                                          SizedBox(width: 5,),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.orange,),
                                              borderRadius: borderRad,
                                            ),
                                            child: Text(" ${ucFirst(payments[index]['status'])} ", style:
                                            TextStyle(fontSize: 14, color: Colors.orange, fontFamily: "PTSans", fontWeight: FontWeight.w700 , )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey,),
                                        borderRadius: borderRad,
                                      ),
                                      child: Text(" ${payments[index]['stripe_payment_id']} ", style:
                                      TextStyle(fontSize: 14, color: Colors.grey, fontFamily: "PTSans", fontWeight: FontWeight.w700 , )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text("Order ID #${payments[index]['order_id']}",
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
                                      Text(payments[index]['created_at'].substring(0,10), style:
                                      TextStyle(fontSize: 13, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                child: Divider(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ): ListTile(title: Center(child: Text("No Payments Yet!",
                style: TextStyle(color: Colors.red),
              ))),
            ],
          ),
        ),
      ): SpecialSpinner(),
    );
  }

  getPaymentHistory() async {
    payments={};
    var res= await CallApi().postData({},'/getUserPaymentHistory');
    var body =json.decode(res.body);
    if(res.statusCode == 200){
      setState(() {
        payments = body['payments'];
        payments = payments.reversed.toList();

        for(int i=0;i<payments.length;i++){
          amountList.insert(i, 0);
        }
      });
      print(payments.toString());
      getPaymentDetails();
      executed = true;
    }
  }

  getPaymentDetails() async {
    for(int i=0;i<payments.length;i++){
      paymentD={};
      var res= await CallApi().postData({"payment_id": payments[i]['stripe_payment_id']},'/getPaymentDetails');
      var body =json.decode(res.body);
      if(res.statusCode == 200){
        setState(() {
          paymentD = body['payment_details'];
        });
        executed1 = true;
      }
      print(paymentD['amount']/100);
      amountList.insert(i, paymentD['amount']/100);
    }
    print(amountList);
  }
}

// class PaymentDetails extends StatefulWidget {
//   final paymentID;
//   const PaymentDetails({this.paymentID});
//
//   @override
//   _PaymentDetailsState createState() => _PaymentDetailsState();
// }
//
// class _PaymentDetailsState extends State<PaymentDetails> {
//   var paymentid;
//   bool executed = false;
//   late var paymentD;
//   @override
//   void initState() {
//    paymentid=widget.paymentID;
//    getPaymentDetails();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Payment of Order ID #", style: TextStyle(fontSize: 18,
//           color: Colors.red,
//           fontFamily: "PTSans",
//           fontWeight: FontWeight.w500,),),
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
//         ),
//       ),
//       body: Center(
//         child: Text(
//           paymentid,
//         ),
//       ),
//     );
//   }
//
//   getPaymentDetails() async {
//     paymentD={};
//     var res= await CallApi().postData({"payment_id": paymentid},'/getPaymentDetails');
//     var body =json.decode(res.body);
//     if(res.statusCode == 200){
//       setState(() {
//         paymentD = body['payment_details'];
//       });
//       print(paymentD.toString());
//       executed = true;
//     }
//   }
//
// }
