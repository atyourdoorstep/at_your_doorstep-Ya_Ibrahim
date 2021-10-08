import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/SellerControl/createPost.dart';
import 'package:at_your_doorstep/Screens/ServicesRelatedPages/requestNewService.dart';
import 'package:at_your_doorstep/Screens/SellerControl/sellerProfileUpdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


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
                          // Text('${(userD['fName'].toString())} ${(userD['lName'].toString())}', style:
                          Text('${ucFirst((userD['fName'].toString()))} ${ucFirst((userD['lName'].toString()))}', style:
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
                  height: roleOfUser == "seller"?400:290,
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
                                    Navigator.push(context, new MaterialPageRoute(
                                        builder: (context) =>UpdateSellerProAndItems()));
                                    // Navigator.of(
                                    //   context,
                                    //   rootNavigator: true,).pushNamed('sellerUpdateProfile');
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
                                     Navigator.push(context, new MaterialPageRoute(
                                         builder: (context) =>PostCreation()));
                                  },
                                  child: ListTile(title: Text("Create New Post / Add Item", style: menuFont,),
                                    leading: Icon(Icons.create_outlined),
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                          ListTile(title: Text("My Address", style: menuFont,),
                            leading: Icon(Icons.location_on),
                          ),
                          Divider(),
                          ListTile(title: Text("Complaints", style: menuFont,),
                            leading: Icon(Icons.edit),
                          ),
                          Divider(),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SuggestNewService()),);
                            },
                            child: ListTile(title: Text("Suggest New Service", style: menuFont,),
                              leading: Icon(Icons.add_chart),
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
                    child: TextButton(
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
                    ),),
              ],
            ),
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
                                 Navigator.of(
                                   context,
                                   rootNavigator: true,).pushNamed('ShowFullImage');
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

