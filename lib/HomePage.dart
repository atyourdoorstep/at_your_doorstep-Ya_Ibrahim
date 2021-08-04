import 'dart:convert';

import 'package:at_your_doorstep/Constants.dart';
import 'package:at_your_doorstep/api.dart';
import 'package:at_your_doorstep/main.dart';
import 'package:at_your_doorstep/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:at_your_doorstep/textFieldClass.dart';
import 'package:blobs/blobs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageOperation();
  }
}

class HomePageOperation extends StatefulWidget {
  const HomePageOperation({Key? key}) : super(key: key);

  @override
  _HomePageOperationState createState() => _HomePageOperationState();
}

class _HomePageOperationState extends State<HomePageOperation> {

  late Map<String,dynamic> userData;
  _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });
    return user;
  }
  _ucFirst(String str)
  {
    if(str.isEmpty)
      return null;
    if(str.length<=1)
      return str.toUpperCase();
    var x=str.toString();
    return x.substring(0,1).toUpperCase()+x.substring(1);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData={};
    _getUserInfo();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
              backgroundColor: Colors.red,
              leading: Icon(Icons.location_on,),
              actions: [
                PopupMenuButton<int>(
                  onSelected: (item)=>onSelected(context,item),
                    itemBuilder: (context)=>[
                      PopupMenuItem<int>(value: 0,child: Text("Profile"),),
                      PopupMenuItem<int>(value: 1,child: Text("Sign Out"),),
                    ],
                ),
              ],
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi, ${_ucFirst(userData['fName'].toString())} ${_ucFirst(userData['lName'].toString())}',style:
                  TextStyle(fontSize: 17, color: Colors.white, fontFamily: "PTSans" )),
                  Row(
                    children: [
                      Text('Deliver to: ',style:
                      TextStyle(fontSize: 13, color: Colors.white, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                      Text('Your Location',style:
                      TextStyle(fontSize: 13, color: Colors.white, fontFamily: "PTSans" )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 180.0,
                  child: ListView(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(18.0),
                            child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNWosb1JiswKwHTROhbee2jJvGPzIt-PInWg&usqp=CAU"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoWWdl6yrERlzK-R4wHHOTI0oIX0djyFzJsw&usqp=CAU"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0gUdOSUpCj1Ua90OToZZ5JICiNVohiiK-cg&usqp=CAU"),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 10),
                  child: Text("Available Services", style:
                  TextStyle(fontSize: 21, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                ),
              ],
            ),
          ),
    );
  }

  onSelected(BuildContext context, int item) {
    switch(item){
      case 1:
        logout();
    }
  }

  void logout() async{
    // logout from the server ...
    var res = await CallApi().getData('/logout');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => MyApp()));
    }
  }
}