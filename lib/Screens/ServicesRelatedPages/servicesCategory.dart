import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Screens/ServicesRelatedPages/servicesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class ServiceCategory extends StatefulWidget {
  final service1;
  final len1;
  final serviceN;
  final ind;

  ServiceCategory({this.serviceN,this.service1,this.len1, this.ind});
  
  @override
  _ServiceCategoryState createState() => _ServiceCategoryState();
}

class _ServiceCategoryState extends State<ServiceCategory> {

  var serviceGen;
  var len;
  var serviceNames;
  late int index;
  var serNameP ;

  @override
  void initState() {

    super.initState();
    serviceGen = widget.service1;
    len = widget.len1;
    serviceNames = widget.serviceN;
    index = widget.ind;
    serNameP = ucFirst(serviceNames["data"][index]['name']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: "Header",
              child: Container(
                height: 500,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                "Services > ${ucFirst(serviceNames["data"]
                                [index]['name'])} > Categories",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black26,
                                    fontFamily: "PTSans",
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                              ucFirst(serviceNames["data"]
                              [index]['name']),
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.red,
                                  fontFamily: "PTSans",
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2.0)),
                        ),
                      ),
                      len > 0 ? SizedBox(
                        height: 300,
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            itemCount: len,
                            itemBuilder: (context, index) {
                              var serviceGen2;
                              serviceGen2 = serviceGen[index]['children'];
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => ServicesPage(
                                            categoryId: serviceGen[index]['id'],
                                            servName: serviceGen[index]['name'],
                                            parentServName: serNameP,)));

                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0,1.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      //border: Border.all(color: Colors.red),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          // Image.asset("assets/atyourdoorstep.png", height: 50,width: 50,),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(ucFirst(serviceGen[index]['name']),
                                              style: TextStyle(
                                                  color: Colors.black45, fontSize: 20.0),),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      ) : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                              "There is no Service Category Available at that Time....",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black45,
                                  fontFamily: "PTSans",
                                  fontWeight: FontWeight.w300)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}