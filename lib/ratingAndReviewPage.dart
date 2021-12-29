import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/paymentPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RatingAndReview extends StatefulWidget {
  const RatingAndReview({Key? key}) : super(key: key);

  @override
  _RatingAndReviewState createState() => _RatingAndReviewState();
}

class _RatingAndReviewState extends State<RatingAndReview> {

  int rating = 0;
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
      body:Center(
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
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText:  ' Write Something ..',
                        ),
                        obscureText: false,
                        //controller: dCodeController,
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
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
