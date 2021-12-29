import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/paymentPage.dart';
import 'package:at_your_doorstep/ratingAndReviewPage.dart';
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
    return DefaultTabController(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
                  ),
                  title: Text(ucFirst(items['name']),style: TextStyle(color: Colors.red),),
                  floating: true,
                  pinned: true,
                  snap: false,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    labelColor: Colors.red,
                    tabs: [
                      Tab(text: ucFirst(items['type']),),
                      Tab(text: "Review",),
                    ],
                  ),
                ),
              ),
            ];
          },
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          Padding(
                            padding: const EdgeInsets.only(right: 16.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {  },
                                  child: Text('Ask me anything', style:
                                  TextStyle(decoration: TextDecoration.underline,
                                      fontSize: 13, color: Colors.blueGrey, fontFamily: "PTSans", fontWeight: FontWeight.w500 )),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                      Visibility(
                        visible: items['type'] == "product" ,
                        child: AYDButton(
                          buttonText: items['inStock'] == 1 ? "Add to cart" : "Out of Stock",
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
                                      content: Text("You logged in as a Guest. Do you want to Register as a Customer?"),
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
                      ),
                      Visibility(
                        visible: items['type'] == "service",
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: AYDButton(
                            buttonText: "Book Now",
                            onPressed: items['inStock'] == 1 ? () async {
                              if(userD['fName'] != "Guest"){

                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => PaymentPage(
                                          ordersList: [ {'item_id': items['id'], 'quantity': 1,}],
                                          itemsDetails: [{'name': items['name'], 'price': items['price'], 'image': items['image']}],
                                        )));
                                // EasyLoading.show(status: 'Creating Order...');
                                // var res= await CallApi().postData({
                                //   'items': [ {
                                //     'item_id': items['id'],
                                //     'quantity': 1,}],
                                // },'/orderCreate');
                                // var body =json.decode(res.body);
                                // print(body.toString());
                                // EasyLoading.dismiss();
                                // if(res.statusCode == 200){
                                //   showMsg(context,"Service Booked Successfully!!");
                                //   showDialog(
                                //       context: context,
                                //       builder: (BuildContext context) {
                                //         return AlertDialog(
                                //           content: Text("Order Created Successfully ", style:
                                //           TextStyle(fontSize: 15, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                                //           title: Column(
                                //             children: [
                                //               Image.asset("assets/atyourdoorstep.png",
                                //                 height: 40,
                                //                 width: 40,
                                //               ),
                                //               SizedBox(height: 5,),
                                //               Text("Order!"),
                                //             ],
                                //           ),
                                //           actions: [
                                //             TextButton(
                                //               onPressed: () {
                                //                 Navigator.pop(context);
                                //               },
                                //               child: Text("Close"),
                                //             ),
                                //           ],
                                //         );
                                //       });
                                //   /////
                                // }
                                // else{
                                //   showMsg(context,"There is some issues");
                                // }
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
                                        content: Text("You logged in as a Guest. Do you want to Register as a Customer?"),
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
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ///
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          //orderItems = orderItems.reversed.toList();
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Sort by "),
                          Icon(Icons.sort),
                        ],
                      ),
                    ),
                  ),
                  items['reviews'].length > 0?SizedBox(
                    height: 500,
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: items['reviews'].length,
                      itemBuilder:(context , index){
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 80,
                                child: Center(
                                  child: ListTile(
                                    trailing:  Text(items['reviews'][index]['created_at'].substring(0,10), style:
                                    TextStyle(fontSize: 10, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${ucFirst(items['reviews'][index]['user']['fName'])} ${ucFirst(items['reviews'][index]['user']['lName'])}" ,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w700),),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                      child: Text(items['reviews'][index]['review'],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black26, fontSize: 15.0),),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 9.0,right: 9.0),
                                child: Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    items['reviews'][index]['rating'] >=1?Icon(Icons.star, size: 13,color: Colors.yellow,) :Icon(Icons.star_border, size: 13,),
                                    items['reviews'][index]['rating'] >=2?Icon(Icons.star, size: 13,color: Colors.yellow,) :Icon(Icons.star_border, size: 13,),
                                    items['reviews'][index]['rating'] >=3?Icon(Icons.star, size: 13,color: Colors.yellow,) :Icon(Icons.star_border, size: 13,),
                                    items['reviews'][index]['rating'] >=4?Icon(Icons.star, size: 13,color: Colors.yellow,) :Icon(Icons.star_border, size: 13,),
                                    items['reviews'][index]['rating'] >=5?Icon(Icons.star, size: 13,color: Colors.yellow,) :Icon(Icons.star_border, size: 13,),

                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        );//categoryItem[index]['image']
                      },
                    ),
                  ):Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: SizedBox(),
                  ),
                  AYDOutlinedButton(
                    buttonText: "Rate it!",
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          RatingAndReview()),);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      ),
      length: 2,
    );
  }
}

///AppBar(
//           elevation: 0.0,
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
//           ),
//           title: Text("Update Profile"),
//           bottom: TabBar(
//             labelColor: Colors.red,
//             tabs: [
//               Tab(text: ucFirst(items['type']),),
//               Tab(text: "Review",),
//             ],
//           ),
//         ),