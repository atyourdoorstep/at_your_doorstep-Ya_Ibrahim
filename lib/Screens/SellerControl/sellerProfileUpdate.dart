import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/SellerControl/sellersPost.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateSellerProAndItems extends StatefulWidget {
  const UpdateSellerProAndItems({Key? key}) : super(key: key);

  @override
  _UpdateSellerProAndItemsState createState() => _UpdateSellerProAndItemsState();
}

class _UpdateSellerProAndItemsState extends State<UpdateSellerProAndItems> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
       appBar: AppBar(
         elevation: 0.0,
         backgroundColor: Colors.white,
         leading: IconButton(
           onPressed: () {
             Navigator.pop(context);
           },
           icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
         ),
         title: Text("Update Profile"),
         bottom: TabBar(
           labelColor: Colors.red,
           tabs: [
             Tab(text: "Edit Profile",),
             Tab(text: "Update Posts",),
           ],
         ),
       ),
        body: TabBarView(
          children: [
            UpdateSellerProfile(),
            SellersPostList(),
          ],
        ),
      ),
      length: 2,
    );
  }
}



class UpdateSellerProfile extends StatefulWidget {
  const UpdateSellerProfile({Key? key}) : super(key: key);

  @override
  _UpdateSellerProfileState createState() => _UpdateSellerProfileState();
}

class _UpdateSellerProfileState extends State<UpdateSellerProfile> {

  bool executed = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  bool _isChanged=false;
  late Map<String,dynamic> userDataSeller={};
getSellerInfo ()async
{
  var inf= await CallApi().postData({}, '/sells');
  var seller = json.decode(inf.body);
  print('seller: '+seller['profile'].toString());
  if(inf.statusCode == 200) {
    setState(() {
      userDataSeller = seller['profile'];
      titleController.text = ucFirst(userDataSeller['title'].toString());
      print(userDataSeller['title'].toString());
      descriptionController.text =
          ucFirst(userDataSeller['description'].toString());
      urlController.text =
      userDataSeller['url'] != null ? userDataSeller['url'].toString() : '';
    });
    executed = true;
  }
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSellerInfo();
    executed = false;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: executed ? SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text("UPDATE PROFILE", style:
                TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
              ),
              SizedBox(
                height: 30,
              ),
              textfieldStyle(textHint: ucFirst( userDataSeller['title'].toString()), obscureText: false, textLabel1:'Title', controllerText: titleController, onChange: (value){setState(() {_isChanged=true;}); },),
              textfieldStyle(textHint:ucFirst(userDataSeller['description'].toString()) , obscureText: false, textLabel1: 'Describe your service', controllerText: descriptionController,onChange:(value) {setState(() {_isChanged=true;}); },),
              textfieldStyle(textHint: userDataSeller['url']!=''? userDataSeller['url'].toString():'', obscureText: false, textLabel1: 'URL',controllerText: urlController,onChange:(value) {setState(() {_isChanged=true;}); },),
              AYDButton(
                buttonText: "Save",
                onPressed: _isChanged?()=>{ _storeSellerInfo({
                  'title':titleController.text.toLowerCase(),
                  'description':descriptionController.text.toLowerCase(),
                  'url':urlController.text.toLowerCase().length>0?urlController.text.toLowerCase():'',
                }
                )}:null,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ): SpecialSpinner(),
    );
  }
  toLocal(String key,String val)async
  {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(key, val);
  }
  _storeSellerInfo(var data ) async {
    if(data['url'].toString().length==0||data['url']==null)
      data.remove('url');
  print ('data: '+data.toString());
    EasyLoading.show(status: 'loading...');
    var res = await CallApi().postData(data, '/updateProfile');
    var body = json.decode(res.body);
    EasyLoading.dismiss();
    print(body);
    if(res.statusCode == 200) {
      if (body != null) {
        if (body['success']!) {
          print(body.toString());
          setState(() {
            userDataSeller = body['profile'];
            _isChanged = false;
          });
        }
        showMsg(context, body['message']);
      }
    }
  }

}