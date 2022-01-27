import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/LandingPages/showItemPage.dart';
import 'package:at_your_doorstep/Screens/Orders/orderDetailPage.dart';
import 'package:at_your_doorstep/Screens/Orders/sellerOrderDetails.dart';
import 'package:at_your_doorstep/Screens/checkOutPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class AskingForAddressOrderTime extends StatefulWidget {
  final striprToken;
  final ordersList;
  final itemsDetails;
  final type;
  AskingForAddressOrderTime({this.type,this.ordersList,this.striprToken, this.itemsDetails});

  @override
  _AskingForAddressOrderTimeState createState() => _AskingForAddressOrderTimeState();
}

class _AskingForAddressOrderTimeState extends State<AskingForAddressOrderTime> {

  TextEditingController addressController = TextEditingController();
  var striprToken;
  var ordersList;
  var itemsDetails;
  var type;
  bool executed = false;
  Location location = new Location();
  late bool serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool _isListenLocation=false;
  bool _isGetLocation=false;
  late String AddressLatLong = "Finding Address Location";
  String addressName="";
  late Map<String,dynamic> address = {};

  @override
  void initState() {
    executed = false;
    getCurrentUserInfo1();
    getLocation();
    addressController.text = currentAddress.toString();
    striprToken = widget.striprToken;
    ordersList = widget.ordersList;
    itemsDetails = widget.itemsDetails;
    type=widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: Colors.red,size: 35,),
        ),
      ),
      body: executed ? SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _isGetLocation?Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  children: [
                    Text("Your Current Location Address is:",
                        overflow: TextOverflow.ellipsis
                        ,style:
                        TextStyle(fontSize: 13, fontFamily: "PTSans" ,fontWeight: FontWeight.bold)),
                  ],
                ),
              ):SizedBox(),
              _isGetLocation ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    addressController.clear();
                    setState(() {
                      addressController.text = AddressLatLong;
                    });
                  },
                  child: Card(
                    child: ListTile(
                      //isThreeLine: true,
                      leading: Icon(Icons.location_on,),
                      title: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("${AddressLatLong}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2
                            ,style:
                            TextStyle(fontSize: 13, fontFamily: "PTSans",color: Colors.black38 )),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          VerticalDivider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ):SizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_isGetLocation?"(IF YOU WANT TO SAVE IT CLICK ON CURRENT ADDRESS & UPDATE IT!!)":"(For Getting Current address please turn on Location)",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4
                    ,style:
                    TextStyle(fontSize: 10, color: Colors.red, fontFamily: "PTSans" )),
              ),
              SizedBox(height: 35),
              Center(
                child: Text("ADD YOUR ADDRESS", style:
                TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
              ),
              SizedBox(
                height: 20,
              ),
              textfieldStyle(textHint: "14 Rajgarh, lahore", obscureText: false, textLabel1:'Enter Hometown Address', controllerText: addressController,),
              SizedBox(
                height: 10,
              ),
              AYDButton(
                onPressed: () async {
                  if(addressController.text.length > 5 ){
                    EasyLoading.show(status: 'Loading...');
                    var res = await CallApi().postData({'address': addressController.text.toLowerCase()}, '/updateUser');
                    var body = json.decode(res.body);
                    setState(() {
                      showMsg(context, body['message']);
                      currentAddress = body['user']['address'];
                    });
                    EasyLoading.dismiss();
                    //Navigator.pop(context);
                    Navigator.pushReplacement(context, new MaterialPageRoute(
                        builder: (context) =>CheckoutPage(
                          type: type,
                          stripToken: striprToken,
                          ordersList: ordersList,
                          itemsDetails: itemsDetails,
                        )));

                  }
                },
                buttonText: "Add & Proceed",
              ),
            ],
          ),
        ),
      ): SpecialSpinner(),
    );
  }

  getCurrentUserInfo1()async {
    var res= await CallApi().postData({},'/getCurrentUser');
    var body =json.decode(res.body);
    EasyLoading.dismiss();
    if(res.statusCode == 200){
      setState(() {
        if(body['user']['address'] == null){
          addressController.text = "Your address here..";
        }
        else{
          currentAddress = body['user']['address'];
          addressController.text = currentAddress;
        }
      });
      executed = true;
      print(currentAddress);
    }
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
      setState(() {
        executed = true;
      });
    }
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

}
