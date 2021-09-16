import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:flutter/material.dart';

class PostCreation extends StatefulWidget {
  const PostCreation({Key? key}) : super(key: key);

  @override
  _PostCreationState createState() => _PostCreationState();
}

class _PostCreationState extends State<PostCreation> {

  bool checkB = false;
  int checkIn = 0;
  bool executed = false;
  bool executed1 = false;
  int categoryID= 0;
  int selectedIndex = 0;
  String parentName ="";
  int getId =0;
  late var categoryList;

  getSellerRegisteredCategory()async
  {
    categoryList ={};
    var info= await CallApi().postData({}, '/getSellerInfo');
    var sellerV = json.decode(info.body);
    if(info.statusCode == 200) {
      setState(() {
        categoryID= sellerV['sellerProfile']["category_id"];
        });
      executed = true;
    }
  }

  getChildrenCategory()async
  {
    var info= await CallApi().postData({}, '/getAllServicesWithChildren');
    var category = json.decode(info.body);
    if(info.statusCode == 200) {
      setState(() {
        categoryFetch = category;
      });
      for(int i=0; i<categoryFetch["data"].length ;i++){
        if(categoryFetch["data"][i]['id']== categoryID){
          setState(() {
            categoryList=categoryFetch["data"][i]["children"];
            parentName=categoryFetch["data"][i]["name"];
            var don = categoryFetch['data'][i]["children"].length;
            print("hello $don");
          });
        }
      }
      executed1 = true;
    }
  }


  @override
  void initState() {
    getSellerRegisteredCategory();
    getChildrenCategory();
    executed = false;
    executed1 = false;
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
      body:executed == true && executed1 == true ? SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("REGISTER SERVICE", style:
                TextStyle(fontSize: 16, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w500 , letterSpacing: 2.0)),
              ),
              Center(
                child: Text("\' $parentName \'", style:
                TextStyle(fontSize: 16, color: Colors.black54, fontFamily: "PTSans", fontWeight: FontWeight.w500 , letterSpacing: 2.0)),
              ),
              Center(
                child: Text("CREATE YOUR POST", style:
                TextStyle(fontSize: 23, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
              ),
              SizedBox(
                height: 30.0,
              ),
              textfieldStyle(textHint: "Item Name", obscureText: false, textLabel1:'Item Name',),
              textfieldStyle(textHint: "Description", obscureText: false, textLabel1:'Description',),
              textfieldStyle(textHint: "Price", obscureText: false, textLabel1:'Adjust item Price',),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Select the type of Service:", style:
                    TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child:categoryList.length > 0 ? ListView.builder(
                      shrinkWrap: true,
                      //scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(categoryFetch.length);
                        return ListTile(
                          title: Text(ucFirst(categoryList[index]['name']),
                          style: TextStyle(
                              color: selectedIndex== index ? Colors.white: Colors.red,
                          ),
                          ),
                          tileColor: selectedIndex== index ? Colors.red: null,
                          onTap: (){
                            setState(() {
                              selectedIndex = index;
                              getId = categoryList[index]['id'];
                              print(getId);
                            });
                          },
                        );
                      }): Text("There is no child"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Do want to Enable Bargain Option"),
                    ),
                    Checkbox(
                        value: checkB,
                        onChanged: (value){
                          setState(() {
                            checkB = value!;
                            if(checkB == true)
                              checkIn = 1;
                            else
                              checkIn = 0;
                            print(checkIn);
                          });
                        }
                    ),

                  ],
                ),
              ),
             Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Text("Add Item Image", style:
                       TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w400)),
                     ],
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         height: 100,
                         width: 100,
                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.black),
                         ),
                         child: Icon(Icons.add),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ): SpecialSpinner(),
    );
  }
}
