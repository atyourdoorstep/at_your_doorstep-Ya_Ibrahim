import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:flutter/material.dart';
import 'package:blobs/blobs.dart';

class Signup2 extends StatelessWidget {
  const Signup2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignupOperation2();
  }
}

enum category {servicePro , customer}

class SignupOperation2 extends StatefulWidget {
  const SignupOperation2({Key? key}) : super(key: key);

  @override
  _SignupOperation2State createState() => _SignupOperation2State();
}
class _SignupOperation2State extends State<SignupOperation2> {

  category _cate = category.customer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
           Stack(
             children: [
               Row(
                 //crossAxisAlignment: CrossAxisAlignment.stretch,
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Blob.random(
                     size: 300,
                     edgesCount: 3,
                     styles: BlobStyles(
                       color: Colors.red,
                     ),
                   ),
                   Blob.animatedRandom(
                     duration: Duration(milliseconds: 400),
                     size: 200,
                     edgesCount: 3,
                     styles: BlobStyles(
                       color: Colors.grey,
                     ),
                   ),
                 ],
               ),
               Center(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     SizedBox(
                       height:50,
                     ),
                     Container(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Image.asset("assets/atyourdoorstep1.png", height: 150,width: 150,),
                         )),
                     SizedBox(
                       height: 30,
                     ),
                     Center(
                       child: Padding(
                         padding: const EdgeInsets.only(left: 12.0, bottom: 6.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Text('Register Yourself',
                                       style:
                                       TextStyle(fontSize: 23, color: Colors.black, fontWeight:FontWeight.w700 , fontFamily: "PTSans" )),
                                   Text('As a',
                                       style:
                                       TextStyle(fontSize: 23, color: Colors.black, fontWeight:FontWeight.w700 , fontFamily: "PTSans" )),
                                 ],
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                     SizedBox(
                       height: 10,
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: <Widget>[
                           ListTile(
                             title: Text('Service Provider'),
                             leading: Radio(
                               value: category.servicePro,
                               groupValue: _cate,
                               onChanged: (category? value) {
                                 setState(() {
                                   _cate = value!;
                                 });
                               },
                             ),
                           ),
                           ListTile(
                             title: Text('Customer'),
                             leading: Radio(
                               value: category.customer,
                               groupValue: _cate,
                               onChanged: (category? value) {
                                 setState(() {
                                   _cate = value!;
                                 });
                               },
                             ),
                           ),
                         ],
                       ),
                     ),
                     SizedBox(
                       height: 10,
                     ),
                     Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: ElevatedButton(
                         style: flatButtonStyle,
                         onPressed: () {  },
                         child: Text('Register',
                             style:
                             TextStyle(fontSize: 18, color: Colors.white)),
                       ),
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
}
