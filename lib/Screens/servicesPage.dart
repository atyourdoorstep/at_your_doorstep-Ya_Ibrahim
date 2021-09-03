import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ServicesPage extends StatefulWidget {
 final servName;
 final parentServName;

 ServicesPage({this.servName, this.parentServName});

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {

  var servName;
  var parentServName;
  @override
  void initState() {
    servName = widget.servName;
    parentServName = widget.parentServName;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
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
                      "Services > $parentServName > Categories > $servName",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black26,
                          fontFamily: "PTSans",
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
