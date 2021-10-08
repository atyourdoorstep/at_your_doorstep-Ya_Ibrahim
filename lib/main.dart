import 'dart:async';
import 'dart:convert';

import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/LandingPages/HomePage.dart';
import 'package:at_your_doorstep/Screens/SearchPage.dart';
import 'package:at_your_doorstep/Screens/LandingPages/SplashScreen.dart';
import 'package:at_your_doorstep/Screens/LandingPages/loginPage.dart';
import 'package:at_your_doorstep/Screens/SellerControl/registerForSeller.dart';
import 'package:at_your_doorstep/Screens/ServicesRelatedPages/requestNewService.dart';
import 'package:at_your_doorstep/Screens/SellerControl/sellerProfileUpdate.dart';
import 'package:at_your_doorstep/Screens/LandingPages/signup_page.dart';
import 'package:at_your_doorstep/Screens/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'At Your Doorstep',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.red,
       // canvasColor: Colors.transparent,

      ),
      home: SplashState(),
      initialRoute: 'SplashPage',
      routes: {
        'SplashPage':(context)=>SplashState(),
        'LoginPage':(context)=>MyHomePage(title: 'AtYourDoorStep'),
        'SignUpPage':(context)=>Signup(),
        'RegisterSeller':(context)=>RegisterSellerOne(),
        'NewServiceSugestion':(context)=>SuggestNewService(),
        'SearchPage':(context)=>SearchPage(),
        'ShowFullImage':(context)=>OpenFullImage(),
        'sellerUpdateProfile':(context)=>UpdateSellerProfile(),
      },
      builder: EasyLoading.init(),
    );
  }
}