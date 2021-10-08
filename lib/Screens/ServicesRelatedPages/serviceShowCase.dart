import 'package:at_your_doorstep/Screens/ServicesRelatedPages/servicesPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: executed ? SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 5.0,),
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.home,size: 25),
                          SizedBox(width: 12.0),
                          Text(ucFirst(serviceNames[0]['name']), style:
                          TextStyle(fontSize: 21, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 7.0,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: List<Widget>.generate(serviceNames[0]['children'].length,
                        (int index){
                      return
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => ServicesPage(
                                        categoryId: serviceNames[0]['children'][index]['id'],
                                        servName: serviceNames[0]['children'][index]['name'],
                                          parentServName: ucFirst(serviceNames[0]['name']), )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Chip(
                                shape: StadiumBorder(side: BorderSide(color: Color(0xffD60024), width: 2)),
                                label:Text(ucFirst(serviceNames[0]['children'][index]['name']),
                                  style: TextStyle(
                                  color: Color(0xffD60024),fontWeight: FontWeight.w500,
                                ),
                              ),
                                  backgroundColor: Color(0xFFFFE7E7) ,
                              ),
                            ),
                          );
                        }
                    ).toList(),
                  ),
                ),
                SizedBox(height: 6.0,),
                ///
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 5.0,),
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.tv,size: 25),
                          SizedBox(width: 12.0),
                          Text(ucFirst(serviceNames[1]['name']), style:
                          TextStyle(fontSize: 21, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 7.0,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: List<Widget>.generate(serviceNames[1]['children'].length,
                            (int index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => ServicesPage(
                                          categoryId: serviceNames[1]['children'][index]['id'],
                                          servName: serviceNames[1]['children'][index]['name'],
                                        parentServName: ucFirst(serviceNames[1]['name']),)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Chip(
                                shape: StadiumBorder(side: BorderSide(color: Color(0xffD60024), width: 2)),
                                label:Text(ucFirst(serviceNames[1]['children'][index]['name']),
                                  style: TextStyle(
                                    color: Color(0xffD60024),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                backgroundColor: Color(0xFFFFE7E7) ,
                              ),
                            ),
                          );
                        }
                    ).toList(),
                  ),
                ),
                SizedBox(height: 6.0,),
                ///
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 5.0,),
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.briefcaseMedical,size: 25),
                          SizedBox(width: 12.0),
                          Text(ucFirst(serviceNames[2]['name']), style:
                          TextStyle(fontSize: 21, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 7.0,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: List<Widget>.generate(serviceNames[2]['children'].length,
                            (int index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => ServicesPage(
                                          categoryId: serviceNames[2]['children'][index]['id'],
                                          servName: serviceNames[2]['children'][index]['name'],
                                        parentServName: ucFirst(serviceNames[2]['name']),)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Chip(
                                shape: StadiumBorder(side: BorderSide(color: Color(0xffD60024), width: 2)),
                                label:Text(ucFirst(serviceNames[2]['children'][index]['name']),
                                  style: TextStyle(
                                    color: Color(0xffD60024),fontWeight: FontWeight.w500,
                                  ),
                                ),
                                backgroundColor: Color(0xFFFFE7E7) ,
                              ),
                            ),
                          );
                        }
                    ).toList(),
                  ),
                ),
                SizedBox(height: 6.0,),
                ///
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 5.0,),
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.book,size: 25),
                          SizedBox(width: 12.0),
                          Text(ucFirst(serviceNames[3]['name']), style:
                          TextStyle(fontSize: 21, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 7.0,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: List<Widget>.generate(serviceNames[3]['children'].length,
                            (int index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => ServicesPage(
                                          categoryId: serviceNames[3]['children'][index]['id'],
                                          servName: serviceNames[3]['children'][index]['name'],
                                        parentServName: ucFirst(serviceNames[3]['name']),)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Chip(
                                shape: StadiumBorder(side: BorderSide(color: Color(0xffD60024), width: 2)),
                                label:Text(ucFirst(serviceNames[3]['children'][index]['name']),
                                  style: TextStyle(
                                    color: Color(0xffD60024),fontWeight: FontWeight.w500,
                                  ),
                                ),
                                backgroundColor: Color(0xFFFFE7E7) ,
                              ),
                            ),
                          );
                        }
                    ).toList(),
                  ),
                ),
                SizedBox(height: 6.0,),
                ///
              ],
            ),
          ),
        ),
      ): SpecialSpinner(),
    );
  }
}
