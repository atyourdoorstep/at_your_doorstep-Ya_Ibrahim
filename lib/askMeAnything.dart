import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/paymentPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AskMeAnything extends StatefulWidget {
  final itemid;
  AskMeAnything({this.itemid});

  @override
  _AskMeAnythingState createState() => _AskMeAnythingState();
}

class _AskMeAnythingState extends State<AskMeAnything> {

  TextEditingController questController = TextEditingController();
  late int itemid;

  @override
  void initState() {
    itemid=widget.itemid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ask me Anything", style: TextStyle(fontSize: 15,
          color: Colors.red,
          fontFamily: "PTSans",
          fontWeight: FontWeight.w500,),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionList(itemid: itemid)),);
              },
              icon: Icon(Icons.mark_chat_unread_sharp, size: 30, color: Colors.red,),
            ),
          ),
        ],
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.red,size: 35,),
        ),
      ),
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("ASK ME!", style:
              TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
            ),
            SizedBox(height: 15),
            textfieldStyle(textHint: "Discount mil jy ga?", obscureText: false, textLabel1:'Type your Question...', controllerText: questController,),
            SizedBox(
              height: 5,
            ),
            AYDButton(
              onPressed: (){},
              buttonText: "Submit",
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionList extends StatefulWidget {
  final itemid;
  QuestionList({this.itemid});

  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {

  late int itemid;
  var getQuestList;
  bool executed = false;

  @override
  void initState() {
    itemid=widget.itemid;
    print(itemid);
    getItemQuestions(itemid);
    executed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asked Questions", style: TextStyle(fontSize: 15,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    //orderItems = orderItems.reversed.toList();
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Sort by "),
                    Icon(Icons.sort),
                  ],
                ),
              ),
            ),
            5 > 0?SizedBox(
              height: 500,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder:(context , index){
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 80,
                          child: Center(
                            child: ListTile(
                              //items['reviews'][index]['created_at'].substring(0,10)
                              trailing:  Text(" ", style:
                              TextStyle(fontSize: 10, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                //${ucFirst(items['reviews'][index]['user']['fName'])} ${ucFirst(items['reviews'][index]['user']['lName'])}
                                child: Text(" " ,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w700),),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                //items['reviews'][index]['review']
                                child: Text("${index}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black26, fontSize: 15.0),),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  );//categoryItem[index]['image']
                },
              ),
            ):Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: SizedBox(height: 100,),
                ),
                ListTile(title: Center(child: Text("No Questions",
                  style: TextStyle(color: Colors.red),
                ))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getItemQuestions(data) async {
    getQuestList={};
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var res= await CallApi().getData('/getItemQuestions?item_id=${data}');
    var body =json.decode(res.body);
    if(res.statusCode == 200){
      setState(() {
        getQuestList = body['itemQuestions'];
        print(getQuestList);
      });
      executed = true;
    }
  }

}
