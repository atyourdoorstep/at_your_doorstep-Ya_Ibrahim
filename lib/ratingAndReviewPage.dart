import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Screens/LandingPages/showItemPage.dart';
import 'package:at_your_doorstep/paymentPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RatingAndReview extends StatefulWidget {
  final itemD;
  RatingAndReview({this.itemD});

  @override
  _RatingAndReviewState createState() => _RatingAndReviewState();
}

class _RatingAndReviewState extends State<RatingAndReview> {

  var items ;
  int rating = 0;
  TextEditingController ReviewController = TextEditingController();
  List designedReviews = [
    "Very Good Service",
    "Amazing Product",
    "Smooth Delivery",
    "Recommended",
    "Really Appreciated ",
    "Bad Service",
    "Not Happy",
    ":)",
  ];
  //R6lamyFoYh

  @override
  void initState() {
    items = widget.itemD;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body:SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Rate It!", style:
                  TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10,),

                      GestureDetector(onTap:(){setState(() {
                        rating=1;
                      });},child: rating >=1?Icon(Icons.star, size: 50,color: Colors.yellow,):Icon(Icons.star_border, size: 50,color: Colors.black12,)),
                      GestureDetector(onTap:(){setState(() {
                        rating=2;
                      });},child: rating >=2?Icon(Icons.star, size: 50,color: Colors.yellow,) :Icon(Icons.star_border, size: 50,color: Colors.black12,)),
                      GestureDetector(onTap:(){setState(() {
                        rating=3;
                      });},child: rating >=3?Icon(Icons.star, size: 50,color: Colors.yellow,) :Icon(Icons.star_border, size: 50,color: Colors.black12,)),
                      GestureDetector(onTap:(){setState(() {
                        rating=4;
                      });},child: rating >=4?Icon(Icons.star, size: 50,color: Colors.yellow,) :Icon(Icons.star_border, size: 50,color: Colors.black12,)),
                      GestureDetector(onTap:(){setState(() {
                        rating=5;
                      });},child: rating >=5?Icon(Icons.star, size: 50,color: Colors.yellow,) :Icon(Icons.star_border, size: 50,color: Colors.black12,)),
                     ],
                  ),
                ),
                SizedBox(height: 13,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText:  ' Write Something ..',
                          ),
                          obscureText: false,
                          controller: ReviewController,
                          onSubmitted: (value){
                            print(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                AYDButton(
                  buttonText: "Rate it!",
                  onPressed: (){
                    rateItem();
                  },
                ),
                SizedBox(height: 7.0,),
                Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    children: List<Widget>.generate(designedReviews.length,
                            (int index){
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                ReviewController.text = ReviewController.text + " "+ designedReviews[index];
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Chip(
                                shape: StadiumBorder(side: BorderSide(color: Color(0xffD60024), width: 2)),
                                label:Text(ucFirst(designedReviews[index]),
                                  style: TextStyle(
                                    color: Color(0xffD60024),fontWeight: FontWeight.w500,
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                //Color(0xFFFFE7E7) ,
                              ),
                            ),
                          );
                        }
                    ).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  rateItem() async {
    if(rating >=1 && ReviewController.text.length >=5){
      var res= await CallApi().postData({
        'item_id': items['id'],
        'review': ReviewController.text,
        'rating': rating,
      },'/RateItem');
      var body =json.decode(res.body);
      if(res.statusCode == 200){
        print(body);
        if(body['success']){
          showMsg(context, "You Rated Successfully");
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(context, new MaterialPageRoute(
              builder: (context) => ShowItemPage(itemDetails: items)));

        }
        else{
          showMsg(context, body['message']);
          }
        }
    }
    else{
      showMsg(context, "Please Reviewed Properly");
    }
  }

}
