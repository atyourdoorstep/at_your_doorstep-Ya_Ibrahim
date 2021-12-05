import 'dart:convert';

import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:flutter/cupertino.dart';
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
  int selectedIndex = 0;
  List<Map<String ,Object>> itemsList = [];
  String? value="";
  TextEditingController discountC = TextEditingController();

  int quantity=1;
  var itemDetails = {};
  @override
  void initState() {
    executed = false;
    getItemsForDiscount();
    super.initState();
  }
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
      body: executed ? SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Choose Item or Service: ", style:
                TextStyle(fontSize: 17, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 130,
                  child: GridView.builder(
                    itemCount: categoryItem.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                    itemBuilder: (context , index){
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            print("List Rank ${index}");
                            itemDetails = categoryItem[index];
                            print("Item ID ${categoryItem[index]['id']}");
                          });
                        },
                        child: Card(
                          color: selectedIndex== index ? Colors.red.withOpacity(0.2): Colors.white,
                          child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    AspectRatio(
                                        aspectRatio: 3/2,
                                    child: Image.network(categoryItem[index]['image'])),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(ucFirst(categoryItem[index]['name']),
                                        overflow: TextOverflow.ellipsis
                                        ,style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),),
                                    ),
                                  ],
                                ),
                              )),
                          shadowColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0),
                            ),
                            side: BorderSide(color: Colors.red),
                          ),),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("  Quantity: ", style:
                    TextStyle(fontSize: 17, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w500 )),
                    SizedBox(width: 2),
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
                    Expanded(child: textfieldStyle(textHint: 'Discount Price', obscureText: false, textLabel1: 'Discount',controllerText: discountC ,keyBoardType: TextInputType.number,inputAction: TextInputAction.next)),

                  ],
                ),
              ),
              AYDButton(
                buttonText: "Add Item",
                onPressed: (){
                 setState(() {
                   if(checkProduct(itemsList ,itemDetails['id'])== 1){
                     for(int i=0;i<itemsList.length;i++){
                       if(itemsList[i]['item_id']== itemDetails['id']){
                         itemsList[i]['quantity'] = quantity;
                         itemsList[i]['discount'] = discountC.text;
                       }
                     }
                     showMsg(context, "Item Updated");
                   }
                   else{
                     if(discountC.text.isNotEmpty) {
                       itemsList.add({
                         'item_id': itemDetails['id'],
                         'name': itemDetails['name'],
                         'discount': discountC.text,
                         'quantity': quantity,
                       });
                     }
                     else{
                       showMsg(context, "Add Discount");
                     }
                   }
                 });
                },
              ),
              ////
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 220,
                  child: ListView.builder(
                    //physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: itemsList.length,
                      itemBuilder:
                          (BuildContext context, int index) {
                        return ListTile(
                          title: Text(itemsList[index]['name'].toString()),
                          subtitle: Text("Discount: ${itemsList[index]['discount'].toString()}  Quantity: ${itemsList[index]['quantity'].toString()}"),
                          trailing: TextButton(onPressed: () {
                            setState(() {
                              itemsList.removeAt(index);
                            });
                          },
                          child: Icon(Icons.restore_from_trash)),
                        );
                      }),
                ),
              ),
              ],
          ),
        ),
      ): SpecialSpinner(),
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        backgroundColor: Colors.red,
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateDiscountCodeSecondPage()));

        },
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
      itemDetails = categoryItem[0];
      print(itemsList);
      executed = true;
    }
  }
  checkProduct(categoryItem1 , int id){
    int flag = 0;
    for(int i=0;i<categoryItem1.length;i++){
      if(categoryItem1[i]['item_id']== id){
        return 1;
      }
    }
    return 0;
  }
}


class CreateDiscountCodeSecondPage extends StatefulWidget {
  CreateDiscountCodeSecondPage();

  @override
  _CreateDiscountCodeSecondPageState createState() => _CreateDiscountCodeSecondPageState();
}

class _CreateDiscountCodeSecondPageState extends State<CreateDiscountCodeSecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Create Discount Code", style: TextStyle(fontSize: 18,
        //   color: Colors.red,
        //   fontFamily: "PTSans",
        //   fontWeight: FontWeight.w500,),),
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
        ),
      ),
    );
  }
}
