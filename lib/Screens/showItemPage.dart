import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/sellerProfileUpdate.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
                          image: NetworkImage(sampleImage),
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
                child: Text(items['inStock'] == 1? "In Stock" :"Out of Stock", style:
                TextStyle(fontSize: 17, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w400 )),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.assistant_photo_outlined),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(items['isBargainAble'] == 1? "It's Bargainable Product " :"This Product or serive is not Bargainable.", style:
                    TextStyle(fontSize: 17, color: Colors.green, fontFamily: "PTSans", fontWeight: FontWeight.w400 )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Price: ", style:
                    TextStyle(fontSize: 17, color: Colors.green, fontFamily: "PTSans", fontWeight: FontWeight.w500 )),
                    Text("   Rs. "+items['price'].toString(), style:
                    TextStyle(fontSize: 25, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                  ],
                ),
              ),
              Padding(
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: Colors.red,
                      onPressed: () {  },
                      child: Text("Add to cart", style:
                      TextStyle(fontSize: 18, color: Colors.white, fontFamily: "PTSans" )),
                    ),
                  ),
                ),
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
