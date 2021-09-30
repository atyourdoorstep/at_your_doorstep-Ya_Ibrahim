import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/sellerProfileUpdate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    getCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                    ),
                    child: Image.network(sampleImage, fit: BoxFit.contain,)),
              ],
            ),
            searchItem.length>0 ? SizedBox(
              height: searchItem.length <= 1  ? 100 : 300,
              child: ListView.builder(
                itemCount: searchItem.length,
                itemBuilder:(context , index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context) =>ShowItemPage(itemDetails: searchItem[index],)));
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0,1.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: 60,
                                    minHeight: 80,
                                  ),
                                  child: Image.network(cartItems[index]['image'], fit: BoxFit.cover,)),
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(ucFirst(cartItems[index]['name']),
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
                                  child: Text("Rs. "+cartItems[index]['price'].toString(), style: TextStyle(
                                    color: Colors.blue,
                                  ),),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );//categoryItem[index]['image']
                },
              ),
            ): ListTile(title: Center(child: Text("Cart is EMPTY !!")),),

          ],
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
