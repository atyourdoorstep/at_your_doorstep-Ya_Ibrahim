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
                    child: Text("Select your privacy: "),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            getQuestList.length > 0?SizedBox(
              height: 700,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: getQuestList.length,
                itemBuilder:(context , index){
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap:(){
                            showModalBottomSheet(
                              elevation: 20.0,
                              context: context,

                              builder: (context) => ReplyBox(
                                item_id: itemid,
                                item_questions_id: getQuestList[index]['id'], ),
                            );
                          },
                          child: Material(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            elevation: 5.0,
                            color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                              child: Text(getQuestList[index]['message'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                              ),
                            ),
                          ),
                        ),
                        getQuestList[index]['child_questions'].length>0? ExpansionTile(
                          title: Text("Answers"),
                          children:[
                            ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: getQuestList[index]['child_questions'].length,
                              itemBuilder:(context , index1){
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Material(
                                        shadowColor: Colors.red,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          bottomLeft: Radius.circular(30.0),
                                          bottomRight: Radius.circular(30.0),
                                        ),
                                        elevation: 5.0,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                          child: Text(getQuestList[index]['child_questions'][index1]['message'],
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );//categoryItem[index]['image']
                              },
                            ),
                          ],
                        ):SizedBox(),
                      ],
                    ),
                  );
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
      var res= await CallApi().getData('/getItemQuestions?item_id=${data}&token=${token}');
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

class ReplyBox extends StatefulWidget {
  final item_id ,item_questions_id;
  ReplyBox({this.item_id,this.item_questions_id});

  @override
  _ReplyBoxState createState() => _ReplyBoxState();
}

class _ReplyBoxState extends State<ReplyBox> {

  late int item_id ,item_questions_id;
  TextEditingController questController = TextEditingController();
  String dropdownValue = 'Public';
  int ispublic =1;

  @override
  void initState() {
    item_id =widget.item_id;
    item_questions_id = widget.item_questions_id;
    super.initState();
  }
  void askNewQuestion2(data)async{
    var resp;
    resp= await CallApi().postData(data, '/createItemQuestion');
    var body = json.decode(resp.body);
    print(body.toString());
    if(body['success']){
      showMsg(context,"Your Query is submit");
      //questController.clear();
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionList(itemid: item_id)),);
    }
    else{
      showMsg(context,body['message']);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Column(
          children: [
            Center(
              child: Text("REPLY!", style:
              TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
            ),
            SizedBox(height: 15),
            textfieldStyle(textHint: "mil jy ga...", obscureText: false, textLabel1:'Type your Question...', controllerText: questController,),
            SizedBox(
              height: 5,
            ),
            AYDButton(
              onPressed: (){
                askNewQuestion2(
                    {
                      'is_public': ispublic,
                      'item_id': item_id,
                      'message': questController.text,
                      'item_questions_id': item_questions_id,
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
}
