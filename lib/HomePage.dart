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

class _HomePageOperationState extends State<HomePageOperation>
    with TickerProviderStateMixin {

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

  //late TabController _tabControl;

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
          body:SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 10),
                  child: Text("Available Services", style:
                  TextStyle(fontSize: 21, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 130,
                    child: GridView(
                      scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                      children: <Widget>[
                        Card(child: Center(child: Text("Home Services")), shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),
                          ),
                          side: BorderSide(color: Colors.red),
                        ),),
                        Card(child: Center(child: Text("Pharmacy")), shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),
                          ),
                          side: BorderSide(color: Colors.red),
                        ),),
                        Card(child: Center(child: Text("Education")), shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),
                          ),
                          side: BorderSide(color: Colors.red),
                        ),),
                        Card(child: Center(child: Text("Electronics")), shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),
                          ),
                          side: BorderSide(color: Colors.red),
                        ),),
                        Card(child: Center(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Request for New Service"),
                        )), shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),
                          ),
                          side: BorderSide(color: Colors.red),
                        ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 10),
                  child: Text("Recommended for you", style:
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
    var res = await CallApi().postData({},'/mobileLogOut');
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

class CupertinoHomePage extends StatelessWidget {
  const CupertinoHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: Colors.transparent,
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home" ),
            BottomNavigationBarItem(icon: Icon(Icons.pages_rounded), label: "Services"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined),label: "Cart"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: "Profile"),
          ],
        ),
        tabBuilder: (context,index){
          switch(index){
            case 0:
              return CupertinoTabView(builder: (context){
                return CupertinoPageScaffold(
                child: HomePage(),);
              }
              );
            case 1:
              return CupertinoTabView(builder: (context){
                return CupertinoPageScaffold(
                  child:  Center(child: Text("hello0"),),);
              }
              );
            case 2:
              return CupertinoTabView(builder: (context){
                return CupertinoPageScaffold(
                  child:  Center(child: Text("hello1"),),);
              }
              );
            case 3:
              return CupertinoTabView(builder: (context){
                return CupertinoPageScaffold(
                  child: SearchPage(),);
              }
              );
            case 4:
              return CupertinoTabView(builder: (context){
                return CupertinoPageScaffold(
                  child: editProfile(),);
              }
              );
            default:
              return CupertinoTabView(builder: (context){
                return CupertinoPageScaffold(
                  child: HomePage(),);
              }
              );
          }

        }
    );
  }
}
