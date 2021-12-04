import 'dart:convert';

import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:flutter/material.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';

class CreateDiscountCodePage extends StatefulWidget {
  @override
  _CreateDiscountCodePageState createState() => _CreateDiscountCodePageState();
}

class _CreateDiscountCodePageState extends State<CreateDiscountCodePage> {
  var categoryItem;
  bool executed = false;
  List<Map<String ,Object>> itemsList = [];

  @override
  void initState() {
    // TODO: implement initState
    executed = false;
    getItemsForDiscount();
    super.initState();
  }
  String dropdownValue = 'Home';
  int idCat = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Discount Code", style: TextStyle(fontSize: 18,
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
      body: Container(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Card(
                  color: Colors.white,
                  //padding: EdgeInsets.all(0.0),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    focusColor: Colors.white,
                    value: dropdownValue,
                    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                    iconEnabledColor: Colors.black,
                    style: const TextStyle(color: Colors.red),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        if(dropdownValue== 'Home')
                          idCat=1;
                        else if(dropdownValue== 'Electronics')
                          idCat=2;
                        else if(dropdownValue== 'Medical & Pharma')
                          idCat=3;
                        else
                          idCat=8;

                        print(idCat);
                      });
                    },
                    items: <String>['Home', 'Electronics', 'Medical & Pharma', 'Education']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    hint: Text("Please select the service type"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  getItemsForDiscount() async {
    categoryItem={};
    var res= await CallApi().postData({},'/sells' );
    var body =json.decode(res.body);
    if(res.statusCode == 200){
      setState(() {
        categoryItem = body['items'];
      });
      for(int i=0;i<categoryItem.length;i++){
        itemsList.insert(i, {
          'item_id': categoryItem[i]['id'],
          'name': categoryItem[i]['name'],
          'description': categoryItem[i]['description'],
        });
      }
      print(itemsList);
      executed = true;
    }
  }
}
