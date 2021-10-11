import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class ShowItemPage extends StatefulWidget {
  final itemDetails;
  ShowItemPage({required this.itemDetails});

  @override
  _ShowItemPageState createState() => _ShowItemPageState();
}

class _ShowItemPageState extends State<ShowItemPage> {

  var items;
  late int quantity;

  @override
  void initState() {
    items = widget.itemDetails;
    quantity = 1;
    print(items.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.6,
                child: Stack(
                  //alignment: AlignmentDirectional.topStart,
                  children: <Widget>[
                    Container(
                      height: size.height * 1.3 - 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(items['image']),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF0B0424).withOpacity(0.2),
                            Color(0xFF0B0424),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Posted Date: ", style:
                    TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                    Text(items['created_at'].substring(0,10), style:
                    TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(ucFirst(items['name']), style:
                TextStyle(fontSize: 25, color: Colors.blueGrey, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(ucFirst(items['description']), style:
                TextStyle(fontSize: 18, color: Colors.grey, fontFamily: "PTSans", fontWeight: FontWeight.w400 )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(items['type'] == "product" ?
                (items['inStock'] == 1? "In Stock" :"Out of Stock"):
                (items['inStock'] == 1? "Available" :"Not Available"),
                    style: TextStyle(fontSize: 17, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w400 )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.assistant_photo_outlined),
                    Text(items['type'] == 'product' ?
                    (items['isBargainAble'] == 1? " Bargainable Product " :" Product is not Bargainable."):
                    (items['isBargainAble'] == 1? " Bargainable Service " :" Service is not Bargainable.")
                        , style:
                    TextStyle(fontSize: 16, color: Colors.green, fontFamily: "PTSans", fontWeight: FontWeight.w400 )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(items['type'] == "product" ?"Price: ":"Charges: ", style:
                    TextStyle(fontSize: 17, color: Colors.green, fontFamily: "PTSans", fontWeight: FontWeight.w500 )),
                    Text(items['type'] == "product" ?"   Rs. "+items['price'].toString() : "   Rs. "+items['price'].toString(), style:
                    TextStyle(fontSize: 25, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                  ],
                ),
              ),
              items['type'] == "product" ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Quantity: ", style:
                    TextStyle(fontSize: 17, color: Colors.green, fontFamily: "PTSans", fontWeight: FontWeight.w500 )),
                    SizedBox(width: 15),
                    TextButton(
                      onPressed: () {
                        if(quantity>1){
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                      child: Text("-", style:
                      TextStyle(fontSize: 25, color: Colors.grey, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                    ),
                    Text(quantity.toString(), style:
                    TextStyle(fontSize: 22, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      child: Text("+".toString(), style:
                      TextStyle(fontSize: 25, color: Colors.grey, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                    ),

                  ],
                ),
              ): SizedBox(),
              AYDButton(
                buttonText: items['type'] == "product" ?
                (items['inStock'] == 1 ? "Add to cart" : "Out of Stock"):
                (items['inStock'] == 1 ? "Avail it" : "Not Available"),
                onPressed: items['inStock'] == 1 ? () async {
                 if(userD['fName'] != "Guest"){
                   EasyLoading.show(status: 'loading...');
                   var res= await CallApi().postData(
                       {
                         "item_id": items['id'],
                         "quantity": quantity,
                       },'/addToCart' );
                   var body =json.decode(res.body);
                   EasyLoading.dismiss();
                   print(body.toString());
                   if(body["success"] == true){
                     showMsg(context, "Add to Cart Successfully",);
                     setState(() {
                       cartCount = body['cart']["cart_items"].length;
                     });
                   }
                   if(body["success"] == false){
                     showMsg(context, body['message'],);
                   }
                 }
                 else{
                   showDialog(
                       context: context,
                       builder: (BuildContext context) {
                         return AlertDialog(
                           title: Column(
                             children: [
                               Image.asset("assets/atyourdoorstep.png",
                                 height: 40,
                                 width: 40,
                               ),
                               SizedBox(height: 6,),
                               Text("Happy For you!"),
                             ],
                           ),
                           content: Text("You are login as a Guest. Do you want to Register as a Customer?"),
                           actions: [
                             TextButton(
                               onPressed: () {
                                 Navigator.pop(context);
                                 Navigator.pop(context);
                               },
                               child: Text("Yes"),

                             ),
                             TextButton(
                               onPressed: () {
                                 Navigator.pop(context);
                               },
                               child: Text("No"),

                             ),
                           ],
                         );
                       }
                   );
                 }

                }: null,
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
