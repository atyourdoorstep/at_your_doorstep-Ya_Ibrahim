import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



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
          elevation: 0.0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.red,
            tabs: [
              Tab(text: "Your Orders",icon: Icon(Icons.reorder,size: 25),),
              Stack(
                  children: [
                    Tab(text: "My Cart",icon: Icon(Icons.shopping_bag_outlined,size: 25),),
                    CircleAvatar(backgroundColor: Colors.red,child: Text("0"),radius: 10,),
                  ]
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("hello")),
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
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                      ),
                      child: Image.network(sampleImage, fit: BoxFit.contain,)),
                  Center(child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("YOUR CART DETAIL",
                      style: TextStyle(
                          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700),),
                  )),
                ],
              ),
              executed ? SizedBox(
                height: cartItems.length <= 1 ? 150 :400,
                child: cartItems.length >= 1 ? ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder:(context , index){
                    return GestureDetector(
                      onTap: (){
                       // Navigator.push(context, new MaterialPageRoute(
                        //   builder: (context) =>ShowItemPage(itemDetails: cartItems[index]['item'])));
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
                ):ListTile(title: Center(child: Text("Cart is Empty !!",
                 style: TextStyle(color: Colors.red),
                )),),
              ): SpecialSpinner(),
              Visibility(
                visible: cartItems.length > 0,
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: AYDButton(
                    buttonText: "Place Order",
                    onPressed: (){},
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
    cartItems={};
    var res= await CallApi().postData({},'/getCart');
    var body =json.decode(res.body);
    if(res.statusCode == 200){
      setState(() {
        cartItems = body['cart']['cart_items'];
        print(cartItems.toString());
      });
      executed = true;
    }
  }

}
