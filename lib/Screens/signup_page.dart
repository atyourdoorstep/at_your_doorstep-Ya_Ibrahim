import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SignupOperation();
  }
}

class SignupOperation extends StatefulWidget {

  @override
  _SignupOperationState createState() => _SignupOperationState();
}

class _SignupOperationState extends State<SignupOperation> {
  bool _isLoading = false;
  DateTime  selectedData=DateTime((DateTime.now().year-18),DateTime.now().month,DateTime.now().day);
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController CNICController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedData,
        firstDate: DateTime(1920, 8),
        lastDate: DateTime((today.year-18),today.month,today.day),
    );
    if (picked != null && picked != selectedData)
      setState(() {
        selectedData = picked;
      });
    dateOfBirthController.text=selectedData.year.toString()+'-'+selectedData.month.toString()+'-'+selectedData.day.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                        child: Text("SIGN UP", style:
                        TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      textfieldStyle(textHint: 'First Name', obscureText: false, textLabel1: 'First Name ',controllerText: firstNameController,keyBoardType: TextInputType.name,inputAction: TextInputAction.next),
                      textfieldStyle(textHint: 'Last Name', obscureText: false, textLabel1: 'Last Name ',controllerText: lastNameController,keyBoardType: TextInputType.name,inputAction: TextInputAction.next),
                      textfieldStyle(textHint: 'CNIC', obscureText: false, textLabel1: 'CNIC ',controllerText: CNICController,keyBoardType: TextInputType.number,inputAction: TextInputAction.next),
                      textfieldStyle(textHint: 'Phone Number', obscureText: false, textLabel1: 'Phone Number ',controllerText: contactController,keyBoardType: TextInputType.phone,inputAction: TextInputAction.next),
                      //textfieldStyle(textHint: 'Home Address', obscureText: false, textLabel1: 'Home Address ',),
                      //textfieldStyle(textHint: 'Date of Birth', obscureText: false, textLabel1: 'Date Of Birth ',),
                      Column(

                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          //Text("${selectedData.toLocal()}".split(' ')[0]),
                          textfieldStyle(textHint: 'Date', obscureText: false, textLabel1: 'Date',controllerText: dateOfBirthController,
                            focus: AlwaysDisable(),
                            suffixButton: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () => _selectDate(context),

                          ),),
                        ],
                      ),
                      textfieldStyle(textHint: 'Email Address', obscureText: false, textLabel1: 'Email Address ',controllerText: mailController,keyBoardType: TextInputType.emailAddress,inputAction: TextInputAction.next),
                      textfieldStyle(textHint: 'Password', obscureText: true, textLabel1: 'Password',controllerText: passwordController, inputAction: TextInputAction.next),
                      textfieldStyle(textHint: 'Confirm Password', obscureText: true, textLabel1: 'Confirm Password ',controllerText: confirmPasswordController,inputAction: TextInputAction.done),
                      AYDButton(
                        buttonText: "Next",
                        onPressed: () {
                          _handleLogin();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });
    EasyLoading.show(status: 'loading...');
    var data = {
      'fName' : firstNameController.text,
      'lName' : lastNameController.text,
      'email' : mailController.text,
      'password' : passwordController.text,
      'password_confirmation' : confirmPasswordController.text,
      'contact' : contactController.text,
      'CNIC' : CNICController.text,
      'date_of_birth' : dateOfBirthController.text,
    };
    //EasyLoading.show(status: 'loading...');
    var res;
    res= await CallApi().postData(data, '/mobileRegister');
    var body = json.decode(res.body);
    //EasyLoading.dismiss();
    print(body.toString());
    EasyLoading.dismiss();
    if(body['success']!=null)
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => CupertinoHomePage(userName: "NewUser",)));
    }
    else{
      showMsg(context,body['message'][0]);
      print('sup: '+body['message'][0].toString());

      //EasyLoading.showToast(body['message']);
    }
    setState(() {
      _isLoading = false;
    });
  }
}

class AlwaysDisable extends FocusNode{
  @override
  bool get hasFocus => false;
}