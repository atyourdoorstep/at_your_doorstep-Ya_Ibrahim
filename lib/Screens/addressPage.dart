import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  Location location = new Location();
  late bool serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool _isListenLocation=false;
  bool _isGetLocation=false;
  late String AddressLatLong = "Finding Address Location";
  TextEditingController addressController = TextEditingController();
  String addressName="";
  bool executed = false;
  late Map<String,dynamic> address = {};
@override
  void initState()  {
  executed = false;
  getSellerAddress();
  getLocation();
  //addressController.text=address['name'].toString();
  super.initState();
  }

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
      body: SafeArea(
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
                    maxLines: 2
                    ,style:
                    TextStyle(fontSize: 10, color: Colors.red, fontFamily: "PTSans" )),
              ),
              SizedBox(height: 35),
              Center(
                child: Text("YOUR ADDRESS", style:
                TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
              ),
              textfieldStyle(textHint: "14 Rajgarh, lahore", obscureText: false, textLabel1:'Enter Hometown Address', controllerText: addressController,),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: addressName == "",
                child: AYDButton(
                  onPressed: (){
                    AddSellerAddress({
                      'name': addressController.text.toString(),
                      'lat': _locationData.latitude,
                      'long': _locationData.longitude,
                    });
                  },
                  buttonText: "Add",
                ),
              ),
              Visibility(
                visible: addressName.length > 0,
                child: AYDButton(
                  onPressed: (){
                    updateSellerAddress({
                      'name': addressController.text.toString(),
                      'lat': _locationData.latitude,
                      'long': _locationData.longitude,
                    });
                  },
                  buttonText: "Update",
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  AddSellerAddress(var data) async{
    var res= await CallApi().postData(data,'/addSellerAddress' );
    var body =json.decode(res.body);
    print(  body.toString());
    if(res.statusCode == 200){
      showMsg(context, 'Address updated');
      if(sAddress == ""){
        sAddress = addressController.text;
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => editProfile()),);

      }
    }
  }
  updateSellerAddress(var data) async{
    var res= await CallApi().postData(data,'/updateSellerAddress' );
    var body =json.decode(res.body);
    print(  body.toString());
    if(res.statusCode == 200){
      print(  body.toString());
      showMsg(context, body['message']);

    }
  }
  getSellerAddress() async{
    var res= await CallApi().postData({},'/getSellersAddress' );
    var body =json.decode(res.body);
    if(res.statusCode == 200){
      print(  body.toString());
      setState(() {
        addressController.text = body['address']['name'].toString();
        addressName = body['address']['name'].toString();
        address=body['address'];
      });
    }
    else if (res.statusCode == 404){
      setState(() {
        addressController.text='';
        address['name']='';
        address['lat']='';
        address['long']='';
      });
    }
    return address;
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
