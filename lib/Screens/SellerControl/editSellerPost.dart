import 'dart:convert';
import 'dart:async';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/SellerControl/sellerProfileUpdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditPost extends StatefulWidget {
  final postId;
  final itemDetails;
  EditPost({required this.postId, required this.itemDetails});

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {

  late int postId;
  bool checkIm = false;

  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();

  bool checkB = false;
  int checkIn = 0;

  bool inStockV = false;
  int stockCheck = 0;

  int price =0;
  var itemImage = "";


  @override
  void initState() {
    postId = widget.itemDetails['id'];
    //set Values
    itemNameController.text = widget.itemDetails['name'].toString();
    itemDescController.text = widget.itemDetails['description'].toString();
    itemPriceController.text = widget.itemDetails['price'].toString();

    setState(() {
      checkB = widget.itemDetails['isBargainAble'] == 1 ? true : false;
      inStockV = widget.itemDetails['inStock'] == 1 ? true : false;
      checkIn = widget.itemDetails['isBargainAble'] == 1 ? 1 : 0;
      stockCheck = widget.itemDetails['inStock'] == 1 ? 1 : 0;
      itemImage = widget.itemDetails['image'];
    });
    print(itemImage.toString());

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
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("UPDATE YOUR POST", style:
                TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Visibility(
                visible: checkIm == false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        checkIm = true;
                      });
                    },
                    child: Text("Update Image",
                        style: TextStyle(fontSize: 14, color: Colors.blue, fontFamily: "PTSans", fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
             Visibility(
               visible: checkIm == true,
               child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Container(
                     child: Stack(
                       alignment: AlignmentDirectional.bottomEnd,
                       children: [
                         ClipRRect(
                             borderRadius: BorderRadius.all(
                               Radius.circular(30.0),),
                             child: Image.network(itemImage, fit: BoxFit.contain,)),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: GestureDetector(
                             onTap: (){
                               showModalBottomSheet(
                                 elevation: 20.0,
                                 context: context,
                                 builder: (context) => Container(
                                   height: 200,
                                   color: Colors.transparent,
                                   child: Container(
                                     decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.only(
                                         topLeft: Radius.circular(10.0),
                                         topRight: Radius.circular(10.0),
                                       ),
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Column(
                                         children: [
                                           GestureDetector(
                                             onTap:() async {
                                               Navigator.of(context).pop();
                                               EasyLoading.show(status: 'loading...');
                                               _updateItemImage(await CallApi().uploadFile(await imgFromGallery(),{}, '/updatePost'));
                                               EasyLoading.dismiss();

                                             },
                                             child: ListTile(
                                               leading: Icon(Icons.photo),
                                               title: Text("Upload From Gallery", style: menuFont,),
                                             ),
                                           ),
                                           Divider(),
                                           GestureDetector(
                                             onTap:() async {
                                               //_imgFromCamera
                                               Navigator.of(context).pop();
                                               EasyLoading.show(status: 'loading...');
                                               _updateItemImage(await CallApi().uploadFile(await imgFromCamera(),{}, '/updatePost'));
                                               EasyLoading.dismiss();
                                             },
                                             child: ListTile(
                                               leading: Icon(Icons.camera),
                                               title: Text("Open Camera", style: menuFont,),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 ),
                               );
                             },
                             child: CircleAvatar(
                               child: Icon(Icons.edit, size: 15,),),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
                 SizedBox(
                   height: 10.0,
                 ),
               ],
             ),
             ),
              textfieldStyle(textHint: "Item Name", obscureText: false, textLabel1:'Item Name',controllerText: itemNameController,),
              textfieldStyle(textHint: "Description", obscureText: false, textLabel1:'Description',controllerText: itemDescController,),
              textfieldStyle(textHint: "Price", obscureText: false, textLabel1:'Adjust item Price',controllerText: itemPriceController,),
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
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: Text("Is Item Or Product available in Stock?"),
                  value: inStockV,
                  onChanged: (bool value) {
                    setState(() {
                      inStockV = value;
                      if(inStockV == true)
                        stockCheck = 1;
                      else
                        stockCheck = 0;
                      print(stockCheck);
                      print(inStockV.toString());
                    });
                  },

                ),
              ),
              AYDButton(
                buttonText: "Save & Publish",
                onPressed:(){

                  _updatePostFunc({
                    'name': itemNameController.text,
                    'description': itemDescController.text,
                    'id': postId,
                    'price': itemPriceController.text,
                    'inStock': stockCheck.toString(),
                    'isBargainAble': checkIn.toString(),
                  });
                },
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

  _updatePostFunc(var data) async {
    EasyLoading.show(status: 'loading...');
    var res = await CallApi().postData(data, '/updatePost');
    var body = json.decode(res.body);
    print(body.toString());
    EasyLoading.dismiss();

    if (body['success']!) {
      print(body.toString());
      showMsg(context,"Your Item Updated Successfully");

      Timer(Duration(seconds: 1),(){
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, new MaterialPageRoute(
            builder: (context) =>UpdateSellerProAndItems()));
      });
    }
    if(body['success'] == false){
      showMsg(context,body['message'].toString());
    }
  }
  _updateItemImage(sendImage)
  {
    var body=json.decode(sendImage.body);
    if( body['success']) {
      showMsg(context, 'Image updated');
      setState(() {
        itemImage=body['item']['image'];
      });
    }
    else
      showMsg(context, 'error in updating image');
  }

}
