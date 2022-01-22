import 'dart:convert';
import 'package:at_your_doorstep/Screens/Cart/cartPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Screens/SearchPage.dart';
import 'package:at_your_doorstep/Screens/ServicesRelatedPages/serviceShowCase.dart';
import 'package:at_your_doorstep/Screens/ServicesRelatedPages/servicesCategory.dart';
import 'package:at_your_doorstep/Screens/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

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

  Location location = new Location();
  late bool serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool _isListenLocation=false;
  bool _isGetLocation=false;
  late String AddressLatLong = "Finding Address Location";


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

  getLocation() async {
    serviceEnabled =await location.serviceEnabled();
    if(!serviceEnabled){
      serviceEnabled = await location.requestService();
      if(serviceEnabled) return;
    }


    _permissionGranted = await location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied){
      _permissionGranted = await location.requestPermission();
      if(_permissionGranted != PermissionStatus.granted) return;
    }

    _locationData = await location.getLocation();
    setState(() {
      _isGetLocation = true;
    });
    
    if(_isGetLocation){
      getsss(_locationData.latitude,_locationData.longitude);
    }
  }


  var serviceNames;
  var topSolds;
  bool executed = false;
  bool executed2 = false;

  @override
  void initState() {
    super.initState();
    userData={};
    getLocation();
    getUserInfo();
    getProfilePicture();
    getParentServices();
    getTopSoldToday();
    if(roleOfUser == "seller") {
      getSellerInfo();
    }
    getCartItemsCount();
    //getSellerNewOrdersCount();
    executed = false;
    executed2 = false;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
              backgroundColor: Colors.red,
              leading: Icon(Icons.location_on,),
              // actions: [
              //   IconButton(
              //       onPressed: (){},
              //       icon: Icon(Icons.notifications_none_rounded, size: 25),
              //   ),
              // ],
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi, ${ucFirst(userD['fName'].toString())} ${ucFirst(userD['lName'].toString())}',style:
                  TextStyle(fontSize: 17, color: Colors.white, fontFamily: "PTSans" )),
                  Row(
                    children: [
                      Text('Deliver to: ',style:
                      TextStyle(fontSize: 13, color: Colors.white, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                      _isGetLocation ? Expanded(
                        child: Text("${AddressLatLong}",
                            overflow: TextOverflow.ellipsis,
                            //maxLines: 2,
                            style:
                        TextStyle(fontSize: 11, color: Colors.white, fontFamily: "PTSans" )),
                      ):
                      Text('Your Location',style:
                      TextStyle(fontSize: 13, color: Colors.white, fontFamily: "PTSans" )),
                       GestureDetector(onTap: () {
                         Navigator.of(
                           context,
                           rootNavigator: true,).pushNamed('mapsGoogle');
                       },
                       child: Icon(Icons.keyboard_arrow_down_outlined, )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: executed && executed2 ? SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 120.0,
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
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Padding(
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
                            child: Hero(
                              tag: "Header",
                              child: Card(
                                child: Center(
                                    child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(serviceNames["data"][index]['name'],style: TextStyle(fontWeight: FontWeight.w500),),
                              )),
                                shadowColor: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0),
                                ),
                                side: BorderSide(color: Colors.red),
                              ),),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 10),
                      child: Text("Top Sold", style:
                      TextStyle(fontSize: 21, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 120,
                    child: GridView.builder(
                      itemCount: topSolds.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                      itemBuilder: (context , index){
                        return GestureDetector(
                          onTap: () {
                            // setState(() {
                            //   selectedIndex = index;
                            //   print("List Rank ${index}");
                            //   itemDetails = categoryItem[index];
                            //   print("Item ID ${categoryItem[index]['id']}");
                            // });
                          },
                          child: Card(
                            //color: selectedIndex== index ? Colors.red.withOpacity(0.2): Colors.white,
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      AspectRatio(
                                          aspectRatio: 2/2,
                                          child: Image.network(topSolds[index]['image'])),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Text(ucFirst(topSolds[index]['name']),
                                      //     maxLines: 2,
                                      //     overflow: TextOverflow.ellipsis
                                      //     ,style: TextStyle(fontWeight: FontWeight.w700, fontSize: 9),),
                                      // ),
                                    ],
                                  ),
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
                // _isGetLocation ? Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 10),
                //   child: Text("Address: ${AddressLatLong} ", style:
                //   TextStyle(fontSize: 14, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                // ): Container(),
              ],
            ),
          ): SpecialSpinner(),
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
      getRoleUser();
      getSellerData();
    }
    return res;
  }

  getTopSoldToday()
  async {
    var res= await CallApi().getData('/topSoldToday');
    if(res.statusCode == 200){
      res =json.decode(res.body);
      setState(() {
        topSolds = res;
        print(topSolds);
      });
      executed2 = true;
    }
    return res;
  }

  getsss(lati,longi) async {
    var _url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lati},${longi}&key=AIzaSyDh0oDKoxQijV3bgBmzkbxt8lxKUkUa2zM';
    http.Response  response = await http.get(Uri.parse(_url));
    if(response.statusCode == 200){
      //print(response.body);
      var res =json.decode(response.body);
      setState(() {
        AddressLatLong = res['results'][0]["formatted_address"];
      });
      print(AddressLatLong);
    }
  }
 //'https://maps.googleapis.com/maps/api/geocode/json?latlng=${31.4015326},${74.2761796}&key=AIzaSyDh0oDKoxQijV3bgBmzkbxt8lxKUkUa2zM'
}

class CupertinoHomePage extends StatefulWidget {

  String userName;
  CupertinoHomePage({required this.userName});

  @override
  _CupertinoHomePageState createState() => _CupertinoHomePageState();
}

class _CupertinoHomePageState extends State<CupertinoHomePage> {

  late DateTime currentBackPressTime;
  late String guestName;
  bool guestCheck=true;
  @override
  void initState() {
    super.initState();
    guestName = widget.userName;
    if(guestName == "Guest"){
      print(guestName);
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
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.home,size: 25), label: "Home" ),
              BottomNavigationBarItem(icon: Icon(Icons.pages_rounded,size: 25), label: "Services"), //Icons.pages_rounded)
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined,size: 25), label: "Cart"), //Icons.shopping_bag_outlined)
              BottomNavigationBarItem(icon: Icon(Icons.search,size: 25), label: "Search"),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.user,size: 25)),
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
                    child:  ServiceOption(),);
                }
                );
              case 2:
                return CupertinoTabView(builder: (context){
                  return CupertinoPageScaffold(
                    child:  CartMainPage());
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

  Future<bool> onWillPop()async{
    DateTime currentTime = DateTime.now();
    bool backButton = currentBackPressTime == null || currentTime.difference(currentBackPressTime) > Duration(seconds: 3);
    if(backButton){
    currentBackPressTime = currentTime;
    showMsg(context, "Double Click to exit App");
    return false;
  }
    return true;
  }

}
