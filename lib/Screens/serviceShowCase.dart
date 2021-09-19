import 'dart:async';
import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/HomePage.dart';
import 'package:at_your_doorstep/Screens/SearchPage.dart';
import 'package:at_your_doorstep/Screens/registerForSeller.dart';
import 'package:at_your_doorstep/Screens/requestNewService.dart';
import 'package:at_your_doorstep/Screens/sellerProfileUpdate.dart';
import 'package:at_your_doorstep/Screens/signup_page.dart';
import 'package:at_your_doorstep/Screens/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ServiceOption extends StatefulWidget {
  const ServiceOption({Key? key}) : super(key: key);

  @override
  _ServiceOptionState createState() => _ServiceOptionState();
}

class _ServiceOptionState extends State<ServiceOption> {
  var serviceNames;
  bool executed = false;

  getServices() async {
    serviceNames={};
    var res= await CallApi().postData({},'/getAllServicesWithChildren' );
    var body =json.decode(res.body);
    if(res.statusCode == 200){
      setState(() {
        serviceNames = body['data'];
      });
      print(body['data'].toString());
      executed = true;
    }
    return res;
  }

  @override
  void initState() {
    super.initState();
    getServices();
    executed = false;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Categories",
          style: TextStyle(
              fontSize: 23,
              color: Colors.white,
              fontFamily: "PTSans",
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0),
        ),
      ),
      body: executed ? SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 5.0,),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Text(ucFirst(serviceNames[0]['name']), style:
                    TextStyle(fontSize: 21, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                  ),
                ],
              ),
              Wrap(
                children: List<Widget>.generate(serviceNames[0]['children'].length,
                    (int index){
                  return
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Chip(
                          label:Text(ucFirst(serviceNames[0]['children'][index]['name']),
                            style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                            backgroundColor: Colors.red ,
                        ),
                      );
                    }
                ).toList(),
              ),
              SizedBox(height: 5.0,),
              ///
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 5.0,),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Text(ucFirst(serviceNames[1]['name']), style:
                    TextStyle(fontSize: 21, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                  ),
                ],
              ),
              Wrap(
                children: List<Widget>.generate(serviceNames[1]['children'].length,
                        (int index){
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Chip(
                              label:Text(ucFirst(serviceNames[1]['children'][index]['name']),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.red ,
                            ),
                      );
                    }
                ).toList(),
              ),
              SizedBox(height: 5.0,),
              ///
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 5.0,),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Text(ucFirst(serviceNames[2]['name']), style:
                    TextStyle(fontSize: 21, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                  ),
                ],
              ),
              Wrap(
                children: List<Widget>.generate(serviceNames[2]['children'].length,
                        (int index){
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Chip(
                              label:Text(ucFirst(serviceNames[2]['children'][index]['name']),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.red ,
                            ),
                      );
                    }
                ).toList(),
              ),
              SizedBox(height: 5.0,),
              ///
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 5.0,),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Text(ucFirst(serviceNames[3]['name']), style:
                    TextStyle(fontSize: 21, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                  ),
                ],
              ),
              Wrap(
                children: List<Widget>.generate(serviceNames[3]['children'].length,
                        (int index){
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Chip(
                              label:Text(ucFirst(serviceNames[3]['children'][index]['name']),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.red ,
                            ),
                      );
                    }
                ).toList(),
              ),
              SizedBox(height: 5.0,),
              ///
            ],
          ),
        ),
      ): SpecialSpinner(),
    );
  }
}
