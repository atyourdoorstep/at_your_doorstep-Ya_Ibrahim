import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Screens/LandingPages/showItemPage.dart';
import 'package:at_your_doorstep/Screens/SellerControl/showSellerProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class SearchInAreaPage extends StatefulWidget {
  const SearchInAreaPage({Key? key}) : super(key: key);

  @override
  _SearchInAreaPageState createState() => _SearchInAreaPageState();
}

class _SearchInAreaPageState extends State<SearchInAreaPage> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  var searchItem;
  var searchItem1;

  bool executed= false;
  bool executed1 = false;
  late String searchWord="";

  Location location = new Location();
  late bool serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool _isListenLocation=false;
  bool _isGetLocation=false;

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
    getSearchItems("new");
  }

  @override
  void initState() {
    searchWord="";
    executed= false;
    executed1= false;
    getLocation();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
          ),
          backgroundColor: Colors.white,
          title: TextField(
            decoration: InputDecoration(
              hintText:  ' Search by services ,provider\'s name',
              // suffixIcon:  Padding(
              //   padding: const EdgeInsets.all(6.0),
              //   child: TextButton(
              //     onPressed: (){
              //       // getDiscount(dCodeController.text);
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => SearchInAreaPage()),);
              //     }, child: Text("Nearby",style:TextStyle(fontSize: 12,)),
              //   ),
              // ),
            ),
            obscureText: false,
            controller: searchController,
            onChanged: (value){
              print(value);
              setState(() {
                searchWord = value;
              });
              if(value != ''){
                getSearchItems(value);
                //getSearchServiceProvider(value);
              }
            },
            // onSubmitted: (value){
            //   if(value != ''){
            //     getSearchItems(value);
            //     getSearchServiceProvider(value);
            //   }
            // },
          ),
          centerTitle: true,
          titleSpacing: 2.0,
        ),
      ),
      body: executed == true ? SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Search Results of : \' $searchWord \'".toString(), style: TextStyle(
                color: Colors.black26,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Product and Services", style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),),
            ),
            searchItem.length>0 ? SizedBox(
              height: searchItem.length <= 1  ? 100 : 300,
              child: ListView.builder(
                itemCount: searchItem.length,
                itemBuilder:(context , index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context) =>ShowItemPage(itemDetails: searchItem[index],)));
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0,1.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: 60,
                                    minHeight: 80,
                                  ),
                                  child: Image.network(searchItem[index]['image'], fit: BoxFit.cover,)),
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(ucFirst(searchItem[index]['name']),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w700),),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  child: Text("Rs. "+searchItem[index]['price'].toString(), style: TextStyle(
                                    color: Colors.blue,
                                  ),),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );//categoryItem[index]['image']
                },
              ),
            ): ListTile(title: Center(child: Text("No product and Service found")),),
          ],
        ),
      ): Container(),
    );
  }

  getSearchItems(var searchWord) async {
    searchItem={};
    if(_isGetLocation){
      //getsss(_locationData.latitude,_locationData.longitude);
      var res= await CallApi().postData(
      {
        'lat':_locationData.latitude,
      'long':_locationData.longitude,
        'radius':10,
        'name':searchWord
      },
          '/itemInRange' );
      var body =json.decode(res.body);
      if(res.statusCode == 200){
        setState(() {
          searchItem = body['result'];
          print(searchItem);
        });
        executed = true;
      }
    }
  }

  // getSearchServiceProvider(var searchWord) async {
  //   searchItem1={};
  //   var res= await CallApi().getData('/searchSeller?search=$searchWord' );
  //   var body =json.decode(res.body);
  //   if(res.statusCode == 200){
  //     setState(() {
  //       searchItem1 = body['result'];
  //     });
  //     executed1 = true;
  //   }
  // }
}
