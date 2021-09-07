import 'dart:async';
import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Screens/SearchPage.dart';
import 'package:at_your_doorstep/Screens/servicesCategory.dart';
import 'package:at_your_doorstep/Screens/userProfile.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
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

  var checkUser = {};
  late Map<String,dynamic> userData;
  getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });
    userD = userData;
    return user;
  }

  var serviceNames;
  bool executed = false;
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData={};
    getUserInfo();
    getProfilePicture();
    getParentServices();
    // Timer(Duration(seconds: 5),(){
    //   print("Loading Screen");
    //   build(context);
    // });
    controller = AnimationController(
        vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    executed = false;

  }
  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
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
                  Text('Hi, ${ucFirst(userD['fName'].toString())} ${ucFirst(userD['lName'].toString())}',style:
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
          body: executed ? SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18.0),
                            child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyzhchKdlDlRAVwZdkEtVWRRGxXxC8PxdqOg&usqp=CAU"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 10),
                      child: Text("Available Services", style:
                      TextStyle(fontSize: 21, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 130,
                    child: GridView.builder(
                      itemCount: serviceNames["data"].length,
                      scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                      itemBuilder: (context , index){
                        return GestureDetector(
                          onTap: () {
                            print(serviceNames["data"][index]['children'].length);
                            int len = serviceNames["data"][index]['children'].length;
                            var serviceGen = serviceNames["data"][index]['children'];

                            showModalBottomSheet(
                                elevation: 20.0,
                                context: context,

                                builder: (context) => ServiceCategory(
                                  serviceN: serviceNames,
                                  service1: serviceNames["data"][index]['children'],
                                  len1: serviceNames["data"][index]['children'].length,
                                  ind: index
                                ),
                              );},
                          child: Card(
                            child: Center(
                                child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(serviceNames["data"][index]['name'],),
                          )),
                            shadowColor: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0),
                            ),
                            side: BorderSide(color: Colors.red),
                          ),),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 10),
                      child: Text("Recommended for you", style:
                      TextStyle(fontSize: 21, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                    ),
                  ],
                ),
              ],
            ),
          ): Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
              CircularProgressIndicator(color: Colors.red,value: controller.value,),
            Image.asset("assets/atyourdoorstep.png", height: 28,width: 28,),
            ],
          ),),
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

  onSelected(BuildContext context, int item) {
    switch(item){
      case 1:
        logout(this.context);
    }
  }
}

class CupertinoHomePage extends StatefulWidget {

  String userName;
  CupertinoHomePage({required this.userName});

  @override
  _CupertinoHomePageState createState() => _CupertinoHomePageState();
}

class _CupertinoHomePageState extends State<CupertinoHomePage> {

  late DateTime currentBackPressTime;
  late String guestname;
  bool guestCheck=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    guestname = widget.userName;
    if(guestname == "Guest"){
      print(guestname);
      setState(() {
        guestCheck = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return guestCheck ? WillPopScope(
      onWillPop: onWillPop,
      child: CupertinoTabScaffold(
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
      ),
    ): CupertinoTabScaffold(
        backgroundColor: Colors.transparent,
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home" ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
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
                  child: SearchPage(),);
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

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      //Fluttertoast.showToast(msg: "Double Tap to Exit");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
