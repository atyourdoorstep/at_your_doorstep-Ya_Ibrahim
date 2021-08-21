import 'dart:convert';

import 'package:at_your_doorstep/Constants.dart';
import 'package:at_your_doorstep/HomePage.dart';
import 'package:at_your_doorstep/api.dart';
import 'package:at_your_doorstep/main.dart';
import 'package:at_your_doorstep/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:at_your_doorstep/textFieldClass.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // _getUserInfo() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var userJson = localStorage.getString('user');
  //   var user = json.decode(userJson!);
  //   setState(() {
  //     userData = user;
  //   });
  //   return user;
  // }
  // _ucFirst(String str)
  // {
  //   if(str.isEmpty)
  //     return null;
  //   if(str.length<=1)
  //     return str.toUpperCase();
  //   var x=str.toString();
  //   return x.substring(0,1).toUpperCase()+x.substring(1);
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData=userD;
    // _getUserInfo();
    fullNameController.text=ucFirst(userData['fName'].toString())+' '+ucFirst(userData['fName'].toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
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
                          // Text('${(userD['fName'].toString())} ${(userD['lName'].toString())}', style:
                          Text('${(userD['fName'].toString())} ${(userD['lName'].toString())}', style:
                          TextStyle(fontSize: 26, color: Colors.black, fontFamily: "PTSans", fontWeight: FontWeight.bold)),
                        ],
                      ),
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
                          ListTile(title: Text("Orders", style: menuFont,),
                            leading: Icon(Icons.shopping_bag_outlined),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //
                SizedBox(
                  height: 280,
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0),
                        ),),
                      child: ListView(
                        physics: ClampingScrollPhysics(),
                        children: [
                          ListTile(title: Text("Complaints", style: menuFont,),
                            leading: Icon(Icons.edit),
                          ),
                          Divider(),
                          ListTile(title: Text("Suggest New Service", style: menuFont,),
                            leading: Icon(Icons.add_chart),
                          ),
                          Divider(),
                          ListTile(title: Text("My Address", style: menuFont,),
                            leading: Icon(Icons.location_on),
                          ),
                          Divider(),
                          TextButton(
                            onPressed: () {
                              logout(context);
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
              ],
            ),
          ),
        ),
      ),
    );
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
        backgroundColor: Colors.red,
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
                          height: 40,
                        ),
                        Center(
                          child: Text("EDIT PROFILE", style:
                          TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 60,
                              backgroundImage: NetworkImage( profilePicUrl),
                              // backgroundImage: NetworkImage("https://www.pngfind.com/pngs/m/676-6764065_default-profile-picture-transparent-hd-png-download.png"),
                            ),
                            GestureDetector(
                              onTap: (){
                                print("Change Image");
                                showModalBottomSheet(
                                  elevation: 20.0,
                                    context: context,
                                    builder: (context) => SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap:(){},
                                                child: ListTile(title: Text("Upload From Gallery", style: menuFont,),
                                                ),
                                              ),
                                              Divider(),
                                              GestureDetector(
                                                onTap:(){},
                                                child: ListTile(title: Text("Open Camera", style: menuFont,),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                );
                              },
                                child: CircleAvatar(child: Icon(Icons.edit, size: 15,),),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        textfieldStyle(textHint: ucFirst(userData['fName'].toString()), obscureText: false, textLabel1:'First Name', controllerText: firstNameController, onChange: (value){setState(() {_isChanged=true;}); },),
                        textfieldStyle(textHint:ucFirst(userData['lName'].toString()) , obscureText: false, textLabel1: 'Last Name', controllerText: lastNameController,onChange:(value) {setState(() {_isChanged=true;}); },),
                        textfieldStyle(textHint: userData['email'].toString(), obscureText: false, textLabel1: 'Email',controllerText: mailController,onChange:(value) {setState(() {_isChanged=true;}); },),
                        textfieldStyle(textHint: userData['contact'].toString(), obscureText: false, textLabel1: 'Phone Number',controllerText: phoneController,onChange: (value){setState(() {_isChanged=true;}); },),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonTheme(
                            minWidth: double.infinity,
                            height: 55,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                                onPressed: _isChanged?()=>{ _save({
                                'fName':firstNameController.text.toLowerCase(),
                                'lName':lastNameController.text.toLowerCase(),
                                'email':mailController.text.toLowerCase(),
                                'contact':phoneController.text.toLowerCase()
                                }
                                )}:null,
                                color: Colors.red,
                                child: Text("Save", style:
                                TextStyle(fontSize: 18, color: Colors.white, fontFamily: "PTSans" )),
                              ),
                            ),
                          ),
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
  _sendTosave()
  {
    _save({
      'fName':firstNameController.text.toLowerCase(),
  'lName':lastNameController.text.toLowerCase(),
    'email':mailController.text.toLowerCase(),
  'contact':phoneController.text.toLowerCase()
  }
    );
  }
  _save(var data ) async {
    print('in FUNC');
    // var data = {
    //   'email' : mailController.text,
    //   'password' : passwordController.text
    // };

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
      } else {
        showMsg(context,body['message']);
        //EasyLoading.showToast(body['message']);
      }
    }
  }

}


