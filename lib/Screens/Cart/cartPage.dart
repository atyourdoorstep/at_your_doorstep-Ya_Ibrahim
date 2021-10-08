import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Screens/Orders/orderListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



class CartMainPage extends StatefulWidget {
  const CartMainPage({Key? key}) : super(key: key);

  @override
  _CartMainPageState createState() => _CartMainPageState();
}

class _CartMainPageState extends State<CartMainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Orders & Cart",
              style: TextStyle(
              fontSize: 23,
              color: Colors.red,
              fontFamily: "PTSans",
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.red,
            tabs: [
              Tab(text: "Your Orders",icon: Icon(Icons.reorder,size: 25),),
              Stack(
                  children: [
                    Tab(text: "My Cart",icon: Icon(Icons.shopping_bag_outlined,size: 25),),
                    cartCount > 0 ? CircleAvatar(backgroundColor: Colors.red,child: Text(cartCount.toString()),radius: 10,) : SizedBox(),
                  ]
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrderInQueue(),
            AddCartPage(),
          ],
        ),
      ),
      length: 2,
    );
  }
}


class AddCartPage extends StatefulWidget {
  const AddCartPage({Key? key}) : super(key: key);

  @override
  _AddCartPageState createState() => _AddCartPageState();
}

class _AddCartPageState extends State<AddCartPage> {

  late var cartItems;
  bool executed = false;
  List<Map<String ,Object>> orderedItems = [];

  @override
  void initState() {
    executed = false;
    setState(() {
      getCartItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              executed ? SizedBox(
                height: cartItems.length <= 1 ? 150 :400,
                child: cartItems.length >= 1 ? ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder:(context , index){
                    return GestureDetector(
                      onTap: (){
                        showMsg(context, "Rs. ${cartItems[index]['item']['price']} , Quantity(s): ${cartItems[index]['quantity']}");
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
                                      child: Text(ucFirst(cartItems[index]['item']['name']),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w700),),
                                ),
                                     Row(
                                       children: [
                                         Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: Text("Rs. "+cartItems[index]['item']['price'].toString(), style: TextStyle(
                                             color: Colors.blue,
                                           ),),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: Text(", Quantity(s): "+cartItems[index]['quantity'].toString(), style: TextStyle(
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
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Row(
                                                children: [
                                                  Image.asset("assets/atyourdoorstep.png",
                                                  height: 40,
                                                    width: 40,
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text("Warning!"),
                                                ],
                                              ),
                                              content: Text(
                                                  "Do you want to delete that item or service? "),
                                              actions: [
                                                TextButton(
                                                  onPressed: () async {
                                                    var res= await CallApi().postData({
                                                      'id': cartItems[index]['id'],
                                                    },'/removeFromCart');
                                                    var body =json.decode(res.body);
                                                    if(res.statusCode == 200){
                                                      Navigator.pop(context);
                                                      executed = false;
                                                      getCartItems();
                                                      setState(() {
                                                        cartCount--;
                                                      });
                                                    }
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
                ):Center(
                  child: ListTile(title: Center(child: Text("Cart is Empty !!",
                   style: TextStyle(color: Colors.red),
                  )),),
                ),
              ): Padding(
                padding: const EdgeInsets.all(8.0),
                child: SpecialSpinner(),
              ),
              Visibility(
                visible: cartItems.length > 0,
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: AYDButton(
                    buttonText: "Place Order",
                    onPressed: () async {
                      if(orderedItems.length > 0){
                        EasyLoading.show(status: 'Creating Order...');
                        var res= await CallApi().postData({
                          'items': orderedItems,
                        },'/orderCreate');
                        var body =json.decode(res.body);
                        EasyLoading.dismiss();
                        if(res.statusCode == 200){
                          showMsg(context,"Order Created Successfully!!");
                          for(int i=0;i<cartItems.length ;i++){
                            var res= await CallApi().postData({
                              'id': cartItems[i]['id'],
                            },'/removeFromCart');
                          }
                              executed = false;
                              getCartItems();
                              setState(() {
                                cartCount = cartItems.length;
                              });
                              ////
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
                                        onPressed: () {
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
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),

            ],
          ),
        ),
      ),
    );
  }
  getCartItems() async {
    orderedItems.clear();
    cartItems={};
    var res= await CallApi().postData({},'/getCart');
    var body =json.decode(res.body);
    if(res.statusCode == 200){
      setState(() {
        cartItems = body['cart']['cart_items'];
      });
      executed = true;
      for(int i=0;i< cartItems.length;i++){
        orderedItems.insert(i, {
          'item_id': cartItems[i]['item_id'],
          'quantity': cartItems[i]['quantity']
        });
      }
      print(orderedItems);
    }
  }
}
