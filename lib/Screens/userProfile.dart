import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Screens/createDiscountCodePage.dart';
import 'package:at_your_doorstep/Screens/paymentsDetailCust.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/Orders/allOrders.dart';
import 'package:at_your_doorstep/Screens/SellerControl/createPost.dart';
import 'package:at_your_doorstep/Screens/SellerControl/notifiedOrders.dart';
import 'package:at_your_doorstep/Screens/ServicesRelatedPages/requestNewService.dart';
import 'package:at_your_doorstep/Screens/SellerControl/sellerProfileUpdate.dart';
import 'package:at_your_doorstep/Screens/addressPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:circular_menu/circular_menu.dart';


class editProfile extends StatelessWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EditProfileOp();
  }
}

class EditProfileOp extends StatefulWidget {
  const EditProfileOp({Key? key}) : super(key: key);
  //final var user
  @override
  _EditProfileOpState createState() => _EditProfileOpState();
}

class _EditProfileOpState extends State<EditProfileOp> {
  late Map<String,dynamic> userData;
  TextEditingController fullNameController = TextEditingController();
  Color _color = Colors.black;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSellerAddressForPostCreation(context);
    userData=userD;
    print(userD['address'].toString());
    //userD['address'] == null
    fullNameController.text=ucFirst(userData['fName'].toString())+' '+ucFirst(userData['fName'].toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        minimum: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hello!", style:
                          TextStyle(fontSize: 17, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w500 )),
                          Text('${ucFirst((userD['fName'].toString()))} ${ucFirst((userD['lName'].toString()))}', style:
                          TextStyle(fontSize: 26, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.bold)),
                          roleOfUser == "seller" ?Text("(Seller id: ${sellerTitle})", style:
                          TextStyle(fontSize: 17, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w500 )):SizedBox(),
                        ],
                      ),
                      SizedBox(width: 12.0),
                    ],
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0),
                        ),),
                      child: ListView(
                        physics: ClampingScrollPhysics(),
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()),);
                            },
                            child: ListTile(title: Text("Edit Profile", style: menuFont,),
                              leading: Icon(Icons.edit),
                            ),
                          ),
                          Divider(),
                          GestureDetector(
                            onTap:(){

                              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistory()),);
                            },
                            child: ListTile(title: Text("Orders", style: menuFont,),
                              leading: Icon(Icons.shopping_bag_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //
                SizedBox(
                  height: roleOfUser == "seller"?410:290,
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0),
                        ),),
                      child: ListView(
                        physics: ClampingScrollPhysics(),
                        children: [
                          Visibility(
                            visible: roleOfUser == "seller",
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,).push(MaterialPageRoute(builder: (context)=>UpdateSellerProAndItems()));

                                  },
                                  child: ListTile(title: Text("Seller Profile", style: menuFont,),
                                    leading: Icon(Icons.account_box_outlined),
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: roleOfUser == "seller",
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap:(){
                                     if(sAddress.length > 1){
                                       showModalBottomSheet(
                                         elevation: 20.0,
                                         context: context,
                                         builder: (context) => Container(
                                           height: 250,
                                           color: Colors.transparent,
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Padding(
                                                 padding: const EdgeInsets.all(9.0),
                                                 child: Text("Create New Post", style:
                                                 TextStyle(fontSize: 20, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                                               ),

                                               Container(
                                                 decoration: BoxDecoration(
                                                   color: Colors.white,
                                                   borderRadius: BorderRadius.only(
                                                     topLeft: Radius.circular(10.0),
                                                     topRight: Radius.circular(10.0),
                                                   ),
                                                 ),
                                                 child: Padding(
                                                   padding: const EdgeInsets.all(8.0),
                                                   child: Column(
                                                     children: [
                                                       GestureDetector(
                                                         onTap:() async {

                                                           Navigator.of(
                                                             context,
                                                             rootNavigator: true,).push(MaterialPageRoute(builder: (context)=>PostCreation(typeofPost: "product",)));
                                                         },
                                                         child: ListTile(
                                                           leading: CircleAvatar(child: Icon(Icons.shopping_bag_outlined)),
                                                           title: Text("Items", style: menuFont,),
                                                         ),
                                                       ),
                                                       Divider(),
                                                       GestureDetector(
                                                         onTap:() async {
                                                           Navigator.of(
                                                             context,
                                                             rootNavigator: true,).push(MaterialPageRoute(builder: (context)=>PostCreation(typeofPost: "service",)));
                                                         },
                                                         child: ListTile(
                                                           leading: CircleAvatar(child: Icon(Icons.home_repair_service)),
                                                           title: Text("Service", style: menuFont,),
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                       );
                                       // Navigator.push(context, new MaterialPageRoute(
                                       //     builder: (context) =>PostCreation()));
                                     }
                                     else{
                                       showDialog(
                                           context: context,
                                           builder: (BuildContext context) {
                                             return AlertDialog(
                                               content: Text("For Creating post you have to Add your Address in \'My Address\' option"),
                                               title:Row(
                                                 children: [
                                                   Image.asset("assets/atyourdoorstep.png",
                                                     height: 40,
                                                     width: 40,
                                                   ),
                                                   SizedBox(width: 5,),
                                                   Text("Warning!"),
                                                 ],
                                               ),
                                               actions: [
                                                 TextButton(
                                                   onPressed: () {
                                                     Navigator.pop(context);
                                                   },
                                                   child: Text("Close"),
                                                 ),
                                               ],
                                             );
                                           });
                                     }
                                  },
                                  child: ListTile(title: Text("Create New Post / Add Item", style: menuFont,),
                                    leading: Icon(Icons.create_outlined),
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(
                                context,
                                rootNavigator: true,).push(MaterialPageRoute(builder: (context)=>PaymentDetailsCustomer()));
                            },
                            child: ListTile(title: Text("Payments", style: menuFont,),
                              leading: Icon(Icons.payment),
                            ),
                          ),
                          Divider(),
                          Visibility(
                            visible: roleOfUser != "seller",
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,).push(MaterialPageRoute(builder: (context)=>SuggestNewService(title: "REQUEST FOR NEW SERVICE")));

                                  },
                                  child: ListTile(title: Text("Suggest New Service", style: menuFont,),
                                    leading: Icon(Icons.add_chart),
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: roleOfUser == "seller",
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,).push(MaterialPageRoute(builder: (context)=>AddAddress()));
                                  },
                                  child: ListTile(title: Text("My Address", style: menuFont,),
                                    leading: Icon(Icons.location_on),
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(
                                context,
                                rootNavigator: true,).push(MaterialPageRoute(builder: (context)=>SuggestNewService(title: "Complaints")));

                            },
                            child: ListTile(title: Text("Complaints", style: menuFont,),
                              leading: Icon(Icons.edit),
                            ),
                          ),
                          Divider(),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Row(
                                        children: [
                                          Image.asset("assets/atyourdoorstep.png",
                                            height: 40,
                                            width: 40,
                                          ),
                                          SizedBox(width: 5,),
                                          Text("Logout"),
                                        ],
                                      ),
                                      content: Text(
                                          "Do you want to Logout? "),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            logout();
                                          },
                                          child: Text("Yes"),

                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("No"),

                                        ),
                                      ],
                                    );
                                  }
                              );
                            },
                            child: ListTile(title: Text("Sign Out", style: menuFont,),
                              leading: Icon(Icons.power_settings_new),

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Visibility(
                  visible: roleOfUser != "seller",
                  child: ButtonTheme(
                    height: 70,
                    hoverColor: Colors.grey,
                    child: ElevatedButton(
                      onPressed: (){

                        Navigator.of(
                          context,
                          rootNavigator: true,).pushNamed('RegisterSeller');

                      },
                      child: Text("Registered as a Service Provider"),
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              TextButton(
                                onPressed: () async {
                                  const url = 'https://atyourdoorstep-pk.herokuapp.com/';
                                  if(await canLaunch(url)){
                                    await launch(url);
                                  }
                                  else{
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Text("About", style: TextStyle(
                                  color: Colors.black45,
                                )),
                              ),
                              Text("|  Version: 1.0.0", style: TextStyle(
                                color: Colors.black45,
                              )),
                            ],
                          ),
                          Visibility(
                            visible: roleOfUser == 'seller',
                            child: TextButton(
                              onPressed: () async {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,).push(MaterialPageRoute(builder: (context)=>SuggestNewService(title: "REQUEST FOR NEW SERVICE")));
                              },
                              child: Text("Suggest New Service", style: TextStyle(
                                fontSize: 11,
                                color: Colors.black45,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton:  Visibility(
        visible: roleOfUser == "seller",
        child: Padding(
          padding: const EdgeInsets.only(top:30.0),
          child: CircularMenu(
            toggleButtonSize: 35,
            alignment: Alignment.topRight,
            toggleButtonColor: Colors.red,
            items: [
              CircularMenuItem(
                  icon: Icons.account_balance_wallet_outlined,
                  color: Colors.green,
                  onTap: () {
                    Navigator.of(
                      context,
                      rootNavigator: true,).push(MaterialPageRoute(builder: (context)=>SellerWallet()));
                  }),
              CircularMenuItem(
                  icon: FontAwesomeIcons.bookOpen,
                  color: Colors.blue,
                  iconSize: 25,
                  onTap: () {
                    Navigator.of(
                      context,
                      rootNavigator: true,).push(MaterialPageRoute(builder: (context)=>NotifiedOrdersList()));
                  }),
              CircularMenuItem(
                  icon: FontAwesomeIcons.ticketAlt,
                  color: Colors.purple,
                  iconSize: 25,
                  onTap: () {
                    Navigator.of(
                      context,
                      rootNavigator: true,).push(MaterialPageRoute(builder: (context)=>CreateDiscountCodePage()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
  void logout() async{

    // logout from the server ...
    var res = await CallApi().postData({},'/mobileLogOut');
    var body = json.decode(res.body);
    if(body['success']||(!body['success']&&body['message'].toString()=='Token has expired')){
      if((!body['success']&&body['message'].toString()=='Token has expired'))
      {
        showMsg(context, 'Session expired please login again');
      }
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.of(
        context,
        rootNavigator: true,).pushNamed('LoginPage');
      Navigator.pop(context);
    }

  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool _isChanged=false;

  late var _image;
  // String url='https://www.pngfind.com/pngs/m/676-6764065_default-profile-picture-transparent-hd-png-download.png';

  late Map<String,dynamic> userData;
  // _getUserInfo() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var userJson = localStorage.getString('user');
  //   var user = json.decode(userJson!);
  //   setState(() {
  //     userData = user;
  //     firstNameController.text=_ucFirst(userData['fName'].toString());
  //     lastNameController.text=_ucFirst(userData['lName'].toString());
  //     mailController.text= userData['email'].toString();
  //     phoneController.text= userData['contact'].toString();
  //   });
  //   return user;
  // }

  @override
  // _getProfilePic()
  // async {
  //   var u=await getProfilePicture();
  //   setState(() {
  //     url=u;
  //   });
  //   print('Profile pic URL: '+url.toString());
  // }
  void initState() {
    // TODO: implement initState
    super.initState();
    userData=userD;
    //load = false;
    // _getUserInfo();
    firstNameController.text=ucFirst(userData['fName'].toString());
    lastNameController.text=ucFirst(userData['lName'].toString());
    mailController.text= userData['email'].toString();
    phoneController.text= userData['contact'].toString();
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
        child: SingleChildScrollView(
          child:  Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text("EDIT PROFILE", style:
                          TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        load? Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            GestureDetector(
                              onTap:(){
                                if(profilePicUrl == 'https://www.pngfind.com/pngs/m/676-6764065_default-profile-picture-transparent-hd-png-download.png'){
                                  showMsg(context,"No Profile Picture");
                                }
                                else{
                                  Navigator.of(
                                    context,
                                    rootNavigator: true,).pushNamed('ShowFullImage');
                                }
                        },
                              child: Hero(
                                tag:"fullsize",
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 60,
                                  backgroundImage: NetworkImage( profilePicUrl),
                                  // backgroundImage: NetworkImage("https://www.pngfind.com/pngs/m/676-6764065_default-profile-picture-transparent-hd-png-download.png"),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                print("Change Image");
                                showModalBottomSheet(
                                  elevation: 20.0,
                                  context: context,
                                  builder: (context) => Container(
                                    height: 200,
                                    color: Colors.transparent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap:() async {
                                                Navigator.of(context).pop();
                                                EasyLoading.show(status: 'loading...');
                                                _updateProfilePicture(await CallApi().uploadFile(await imgFromGallery(),{}, '/setProfilePicture'));
                                                EasyLoading.dismiss();

                                              },
                                              child: ListTile(
                                                leading: Icon(Icons.photo),
                                                title: Text("Upload From Gallery", style: menuFont,),
                                              ),
                                            ),
                                            Divider(),
                                            GestureDetector(
                                              onTap:() async {
                                                //_imgFromCamera
                                                Navigator.of(context).pop();
                                                EasyLoading.show(status: 'loading...');
                                                _updateProfilePicture(await CallApi().uploadFile(await imgFromCamera(),{}, '/setProfilePicture'));
                                                EasyLoading.dismiss();
                                              },
                                              child: ListTile(
                                                leading: Icon(Icons.camera),
                                                title: Text("Open Camera", style: menuFont,),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.edit, size: 15,),),
                            ),
                          ],
                        ): CircleAvatar(
                          child: CircularProgressIndicator(),
                          backgroundColor: Colors.grey,
                          radius: 60,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        textfieldStyle(textHint: ucFirst(userData['fName'].toString()), obscureText: false, textLabel1:'First Name', controllerText: firstNameController, onChange: (value){setState(() {_isChanged=true;}); },),
                        textfieldStyle(textHint:ucFirst(userData['lName'].toString()) , obscureText: false, textLabel1: 'Last Name', controllerText: lastNameController,onChange:(value) {setState(() {_isChanged=true;}); },),
                        textfieldStyle(textHint: userData['email'].toString(), obscureText: false, textLabel1: 'Email',controllerText: mailController,onChange:(value) {setState(() {_isChanged=true;}); },),
                        textfieldStyle(textHint: userData['contact'].toString(), obscureText: false, textLabel1: 'Phone Number',controllerText: phoneController,onChange: (value){setState(() {_isChanged=true;}); },),
                        AYDButton(
                          buttonText: "Save",
                          onPressed: _isChanged?()=>{
                            _save({
                              'fName':firstNameController.text.toLowerCase(),
                              'lName':lastNameController.text.toLowerCase(),
                              'email':mailController.text.toLowerCase(),
                              'contact':phoneController.text.toLowerCase()
                            })
                          }:null,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  toLocal(String key,String val)async
  {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(key, val);
  }
  _save(var data ) async {
    print('in FUNC');
    EasyLoading.show(status: 'loading...');
    var res = await CallApi().postData(data, '/updateUser');
    var body = json.decode(res.body);
    EasyLoading.dismiss();
    print(body);
    if (body != null){
      if (body['success']!) {
        print(body.toString());
        toLocal('user', json.encode(body['user']));
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var userJson = localStorage.getString('user');
        var user = json.decode(userJson!);
        setState(() {
          userD = user;
          _isChanged=false;
        });
      }
      showMsg(context,body['message']);
      //EasyLoading.showToast(body['message']);
    }
  }
  _updateProfilePicture(msg)
  {
    var body=msg.data;
    if( body['success']) {
      showMsg(context, 'Image updated');
      setState(() {
        profilePicUrl=body['profile']['image'];
      });
    }
    else
      showMsg(context, 'error in updating image');
  }


}


class OpenFullImage extends StatefulWidget {
  const OpenFullImage({Key? key}) : super(key: key);

  @override
  _OpenFullImageState createState() => _OpenFullImageState();
}

class _OpenFullImageState extends State<OpenFullImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile photo", style: TextStyle(fontSize: 25,
          color: Colors.red,
          fontFamily: "PTSans",
          fontWeight: FontWeight.w500,),),
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
        ),
        actions: [
          IconButton(
            onPressed: () {
                print("Change Image");
                showModalBottomSheet(
                  elevation: 20.0,
                  context: context,
                  builder: (context) => Container(
                    height: 200,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap:() async {
                                // final ImagePicker _picker = ImagePicker();
                                // XFile image = await _picker.pickImage(
                                //     source: ImageSource.gallery, imageQuality: 50
                                // ) as XFile;
                                _imgFromGallery();
                                Navigator.of(context).pop();
                                EasyLoading.dismiss();
                              },
                              child: ListTile(
                                leading: Icon(Icons.photo),
                                title: Text("Upload From Gallery", style: menuFont,),
                              ),
                            ),
                            Divider(),
                            GestureDetector(
                              onTap:() async {

                                _imgFromCamera();
                                Navigator.of(context).pop();
                                EasyLoading.dismiss();
                              },
                              child: ListTile(
                                leading: Icon(Icons.camera),
                                title: Text("Open Camera", style: menuFont,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
            },
            icon: Icon(Icons.edit, color: Colors.red,size: 35,),
          ),
          SizedBox(),
        ],
      ),
      body: Hero(
        tag:"fullsize",
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage( profilePicUrl),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }


  _imgFromCamera() async {

    EasyLoading.show(status: 'loading...');
    final ImagePicker _picker = ImagePicker();
    XFile image = await _picker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ) as XFile;
    print("cam: "+image.path.toString());
    var msg=await CallApi().uploadFile(image,{}, '/setProfilePicture');
    var body=msg.data;

    if( body['success']) {
      showMsg(context, 'Image updated');
      setState(() {
        profilePicUrl=body['profile']['image'];

      });

      Navigator.pop(context);
    }
    else
      showMsg(context, 'error in updating image');
    EasyLoading.dismiss();
  }
  _imgFromGallery() async {

    EasyLoading.show(status: 'loading...');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    final ImagePicker _picker = ImagePicker();
    XFile image = await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ) as XFile;
    var msg=await CallApi().uploadFile(image,{}, '/setProfilePicture');
    var body=msg.data;
    if( body['success']) {
      showMsg(context, 'Image updated');
      setState(() {
        profilePicUrl=body['profile']['image'];
      });
      Navigator.pop(context);
    }
    else
      showMsg(context, 'error in updating image');
    EasyLoading.dismiss();
  }

}

class SellerWallet extends StatefulWidget {
  const SellerWallet({Key? key}) : super(key: key);

  @override
  _SellerWalletState createState() => _SellerWalletState();
}

class _SellerWalletState extends State<SellerWallet> {

  var amount =0;
  bool executed = false;

  @override
  void initState() {
    executed = false;
    getWallet();
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
      body: executed?Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("YOUR WALLET", style:
            TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
          ),
    SizedBox(
    height: 20,
    ),
          Center(
            child: Text(amount.toString(), style:
            TextStyle(fontSize: 30, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
          ),
        ],
      ):SpecialSpinner(),


    );
  }
  getWallet()
  async {
    amount=0;
    var res= await CallApi().postData({},'/getWallet');
    var body1 =json.decode(res.body);
    if(res.statusCode == 200){
      setState(() {
        amount = body1['wallet']['amount'];
      });
      executed = true;
    }
  }
}
