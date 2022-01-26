import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/buttonClass.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
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
  String dropdownValue = 'Public';
  int ispublic =1;


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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text("Do you want to show your question Public or Private: "),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: DropdownButton(
                      focusColor: Colors.white,
                      value: dropdownValue,
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      iconEnabledColor: Colors.black,
                      style: const TextStyle(color: Colors.red),
                      onChanged: (String? newValue){
                        setState(() {
                          dropdownValue = newValue!;
                          ispublic = dropdownValue == 'Public'? 1 : 0;
                        });
                        print(ispublic);
                      },
                      items: <String>['Public', 'Private']
                          .map<DropdownMenuItem<String>>((String value){
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(value),
                          ),
                        );
                      }
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
            textfieldStyle(textHint: "Discount mil jy ga?", obscureText: false, textLabel1:'Type your Question...', controllerText: questController,),
            SizedBox(
              height: 5,
            ),
            AYDButton(
              onPressed: (){
                askNewQuestion(
                  {
                    'is_public': ispublic,
                    'item_id': itemid,
                    'message': questController.text,
                  }
                );
              },
              buttonText: "Submit",
            ),
          ],
        ),
      ),
    );
  }

  void askNewQuestion(data)async{
    var resp;
    resp= await CallApi().postData(data, '/createItemQuestion');
    var body = json.decode(resp.body);
    print(body.toString());
    if(body['success']){
      showMsg(context,"Your Query is submit");
      questController.clear();
    }
    else{
      showMsg(context,body['message']);
    }
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
    getQuestList={};
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
      body: executed? SingleChildScrollView(
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
            getQuestList.length > 0?SizedBox(
              height: 500,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: getQuestList.length,
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
                              //trailing:  Text(getQuestList[index]['created_at'].substring(0,10), style:
                              //TextStyle(fontSize: 10, color: Colors.black26, fontFamily: "PTSans", fontWeight: FontWeight.w700 )),
                              title:  Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                //items['reviews'][index]['review']
                                child: Text("Q. "+getQuestList[index]['message'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: Colors.red.shade400, fontSize: 15.0),),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getQuestList[index]["child_questions"].length > 0 ?Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8.0, top: 5),
                                    child: Text("A. "+getQuestList[index]["child_questions"][0]['message'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: Colors.black26, fontSize: 15.0),),
                                  ):SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
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
      ): SpecialSpinner(),
    );
  }

  getItemQuestions(data) async {
    setState(() {
      getQuestList={};
    });
    if(userD['fName'] != 'Guest'){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      var res= await CallApi().getData('/getItemQuestions?item_id=${data}');
      var body1 =json.decode(res.body);
      if(res.statusCode == 200){
        setState(() {
          getQuestList = body1['itemQuestions'];
          print(data);
          print(getQuestList);
        });
        executed = true;
      }
    }
    else{
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

}
