import 'dart:async';
import 'dart:convert';

import 'package:at_your_doorstep/Constants.dart';
import 'package:at_your_doorstep/SearchPage.dart';
import 'package:at_your_doorstep/api.dart';
import 'package:at_your_doorstep/main.dart';
import 'package:at_your_doorstep/signup_page.dart';
import 'package:at_your_doorstep/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:at_your_doorstep/textFieldClass.dart';
import 'package:blobs/blobs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';


class ServiceCategory extends StatefulWidget {
  final sName;

  ServiceCategory({this.sName});
  
  @override
  _ServiceCategoryState createState() => _ServiceCategoryState();
}

class _ServiceCategoryState extends State<ServiceCategory> {

  late String name;

  var serviceNames;
  bool executed = false;
  //late TabController _tabControl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.sName;
    getParentServices();
    // Timer(Duration(seconds: 5),(){
    //   print("Loading Screen");
    //   build(context);
    // });
    executed = false;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: executed ? Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(ucFirst(name), style:
              TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 180.0,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: serviceNames["data"].length,
                //scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                    return serviceNames["data"][index]['name'] == name?  Text(serviceNames["data"][index]['name']): Text("Nothing Found");

              },
              ),
            ),
          ),
        ],
      ): Center(child: CircularProgressIndicator(color: Colors.red,),),
    );
  }

  getParentServices()
  async {
    var res= await CallApi().postData({},'/getAllServicesWithChildren' );
    if(res.statusCode == 200){
      res =json.decode(res.body);
      setState(() {
        serviceNames = res;
      });
      executed = true;
      //print(  serviceNames[0].toString());
    }
    print(res.toString());
    return res;
  }

}
