import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Screens/servicesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class RegisterSellerOne extends StatefulWidget {
  const RegisterSellerOne({Key? key}) : super(key: key);

  @override
  _RegisterSellerOneState createState() => _RegisterSellerOneState();
}

class _RegisterSellerOneState extends State<RegisterSellerOne> {

  String dropdownValue = 'Home';

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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text("REGISTER YOURSELF AS A", style:
              TextStyle(fontSize: 16, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w500 , letterSpacing: 2.0)),
            ),
            Center(
              child: Text("SERVICE PROVIDER", style:
              TextStyle(fontSize: 23, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text("Select the type of Service:", style:
              TextStyle(fontSize: 15, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                 color: Colors.white,
                  //padding: EdgeInsets.all(0.0),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    focusColor: Colors.white,
                    value: dropdownValue,
                    // icon: const Icon(Icons.arrow_downward),
                    // iconSize: 24,
                    iconEnabledColor: Colors.black,
                    style: const TextStyle(color: Colors.red),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Home', 'Electronics', 'Medical & Pharma', 'Education']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Text("Please select the service type"),
                  ),
                ),
              ),
            ),
            ///
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0),
                        ),
                        side: BorderSide(color: Colors.red),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => Signup()),
                        // );
                      },
                      color: Colors.red,
                      child: Text("Next", style:
                      TextStyle(fontSize: 18, color: Colors.white, fontFamily: "PTSans" )),
                    ),
                  ),
                ),
              ),
            ),
            ///
          ],
        ),
      ),
    );
  }
}
