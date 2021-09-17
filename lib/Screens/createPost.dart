import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
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
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              width: MediaQuery.of(context).size.height/7,
                              height: 70,
                              decoration: BoxDecoration(
                                color: selectedIndex== index ? Colors.red : null,
                                border:
                                Border.all(color: selectedIndex== index ?  Colors.red :  Colors.black),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                    ucFirst(categoryList[index]['name']),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: selectedIndex== index ? Colors.white: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: (){
                            setState(() {
                              selectedIndex = index;
                              getId = categoryList[index]['id'];
                              print(getId);
                            });
                          },
                        );
                      }),
                ),
              ),
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () async {
                        if(itemPriceController.text != '' && checkIn != null &&
                            itemDescController.text != '' && getId != null &&
                            itemNameController.text != ''){
                          SharedPreferences localStorage = await SharedPreferences.getInstance();
                          XFile x=await imgFromGallery();
                          _createPostFunc(
                              {
                                'token': localStorage.getString('token'),
                                'name': itemNameController.text,
                                'description': itemDescController.text,
                                'category_id': getId,
                                'price': itemPriceController.text,
                                'image':x,
                                'isBargainAble': checkIn
                              }
                          );
                          Navigator.pop(context);
                          // Navigator.push(context, new MaterialPageRoute(
                          //     builder: (context) =>PostCreationTwo(
                          //       iPrice: itemPriceController.text,
                          //       checkB: checkIn,
                          //       itemDesc: itemDescController.text,
                          //       CategoryId: getId,
                          //       itemN: itemNameController.text,
                          //     )));
                        }
                        else {
                            showMsg(context, "Fill up above Required fields");
                          }

                      },
                      color: Colors.red,
                      child: Text("Upload Image & Publish", style:
                      TextStyle(fontSize: 18, color: Colors.white, fontFamily: "PTSans" )),
                    ),
                  ),
                ),
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
  _createPostFunc(var data) async {
    EasyLoading.show(status: 'loading...');
    var res = await CallApi().postData(data, '/createPost');
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

class PostCreationTwo extends StatefulWidget {
  late final String itemN , itemDesc, iPrice;
  late final int checkB , CategoryId;

  PostCreationTwo({required this.checkB,required this.CategoryId,required this.iPrice,required this.itemDesc,required this.itemN});
  @override
  _PostCreationTwoState createState() => _PostCreationTwoState();
}

class _PostCreationTwoState extends State<PostCreationTwo> {

  late String itemN , itemDesc, iPrice;
  late int checkB , CategoryId;

  @override
  void initState() {
    itemN = widget.itemN;
    itemDesc = widget.itemDesc;
    iPrice = widget.iPrice;
    checkB = widget.checkB;
    CategoryId = widget.CategoryId;
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      XFile x = await imgFromGallery();
                    },
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.camera_enhance_outlined, size: 45,),
                          Text("Upload Item Photo"),
                        ],
                      ),
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
