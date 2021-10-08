import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostCreation extends StatefulWidget {
  const PostCreation({Key? key}) : super(key: key);

  @override
  _PostCreationState createState() => _PostCreationState();
}

class _PostCreationState extends State<PostCreation> {

  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  bool checkB = false;
  int checkIn = 0;
  bool executed = false;
  bool executed1 = false;
  int categoryID= 0;
  int selectedIndex = 0;
  int selectedIndex1 = 0;
  String parentName ="";
  int getId =0;
  int getId1 =0;
  late var currentServiceDetails;
  late var categoryList;
  bool load3rd = false;

  getSellerRegisteredCategory()async
  {
    currentServiceDetails = {};
    categoryList ={};
    var info= await CallApi().postData({}, '/getSellerInfo');
    var sellerV = json.decode(info.body);
    if(info.statusCode == 200) {
      setState(() {
        categoryID= sellerV['sellerProfile']["category_id"];
      });
      executed = true;
      getChildrenCategory();
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
    //getChildrenCategory();
    executed = false;
    executed1 = false;
    load3rd = false;
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
              textfieldStyle(textHint: "Item Name", obscureText: false, textLabel1:'Item Name',controllerText: itemNameController,),
              textfieldStyle(textHint: "Description", obscureText: false, textLabel1:'Description',controllerText: itemDescController,),
              textfieldStyle(textHint: "Price", obscureText: false, textLabel1:'Adjust item Price',controllerText: itemPriceController,),
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
                  height: 35,
                  child: ListView.builder(
                    //physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder:
                          (BuildContext context, int index) {
                        return GestureDetector(
                          child: Row(
                            children: [
                              Chip(
                                label: Text(ucFirst(categoryList[index]['name']),
                                  style: TextStyle(
                                    color: selectedIndex== index ? Colors.white: Colors.black,
                                  ),
                                ),
                                backgroundColor: selectedIndex== index ? Colors.red : null,
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                          onTap: (){
                            setState(() {
                              selectedIndex = index;
                              getId = categoryList[index]['id'];
                              currentServiceDetails = categoryList[index]['children'];
                              getId1 = 0;
                              print("id of current service ${getId1}");
                              print(currentServiceDetails.toString());
                              load3rd = true;
                            });
                          },
                        );
                      }),
                ),
              ),
              ////

              Visibility(
                visible: load3rd,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Select the type of Service Children:", style:
                          TextStyle(fontSize: 15, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: currentServiceDetails.length > 0 ? SizedBox(
                        height: 35,
                        child: ListView.builder(
                          //physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: currentServiceDetails.length,
                            itemBuilder:
                                (BuildContext context, int index) {
                              return GestureDetector(
                                child: Row(
                                  children: [
                                    Chip(
                                      label: Text(ucFirst(currentServiceDetails[index]['name']),
                                        style: TextStyle(
                                          color: selectedIndex1== index ? Colors.white: Colors.black,
                                        ),
                                      ),
                                      backgroundColor: selectedIndex1== index ? Colors.red : null,
                                    ),
                                    SizedBox(width: 8),
                                  ],
                                ),
                                onTap: (){
                                  setState(() {
                                    selectedIndex1 = index;
                                    getId1 = currentServiceDetails[index]['id'];
                                    print("id of current service ${getId1}");
                                    print(getId1);
                                  });
                                },
                              );
                            }),
                      ):  Center(
                        child: Text("No Service Children",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
              ////
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CheckboxListTile(
                    value: checkB,
                    title: Text("Do want to Enable Bargain Option?"),
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
              ),
              AYDButton(
                onPressed: () async {
                  if(itemPriceController.text != '' && checkIn != null &&
                      itemDescController.text != '' && getId1 != 0 &&
                      itemNameController.text != ''){
                    SharedPreferences localStorage = await SharedPreferences.getInstance();
                    XFile image =await imgFromGallery();
                    _createPostFunc(image,{
                      'token': localStorage.getString('token'),
                      'name': itemNameController.text,
                      'description': itemDescController.text,
                      'category_id': getId1,
                      'price': itemPriceController.text,
                      'isBargainAble': checkIn
                    }
                    );
                  }
                  else {
                    showMsg(context, "Fill up & Select above Required fields");
                  }

                },
               buttonText: "Upload Image & Publish",
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ): Align(alignment: Alignment.center,
          child: SpecialSpinner()),
    );
  }
  _createPostFunc(file,var data) async {
    EasyLoading.show(status: 'loading...');
    var res = await CallApi().uploadFile(file,data, '/createPost');
    var body = json.decode(res.body);
    EasyLoading.dismiss();
    if (body['success']!) {
      print(body.toString());
      showMsg(context,"Your Item Published Successfully");
    }
    else{
      showMsg(context,body['message']);
    }
  }
}