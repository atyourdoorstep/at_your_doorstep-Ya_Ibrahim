import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Screens/LandingPages/showItemPage.dart';
import 'package:at_your_doorstep/Screens/Orders/orderDetailPage.dart';
import 'package:at_your_doorstep/Screens/Orders/sellerOrderDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowSellerProfile extends StatefulWidget {
  final sellerID;
  ShowSellerProfile({this.sellerID});

  @override
  _ShowSellerProfileState createState() => _ShowSellerProfileState();
}

class _ShowSellerProfileState extends State<ShowSellerProfile> {

  late int sellerID;
  var sellerResult;
  bool executed = false;

  @override
  void initState() {
    sellerID = widget.sellerID;
    sellerProfile(sellerID);
    executed = false;
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
      body: executed? SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
          CircleAvatar(
            radius: 60,
          foregroundImage: NetworkImage(
            sellerResult['profile']['image'] == null ?
            'https://www.pngfind.com/pngs/m/676-6764065_default-profile-picture-transparent-hd-png-download.png' :
            sellerResult['profile']['image'],),

          child: Text(sellerResult['profile']['id'].toString()),),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(ucFirst(sellerResult['profile']['title'] == null ? "No title" : sellerResult['profile']['title']),
                  style: TextStyle(
                    color: Colors.black54,fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              sellerResult['profile']['url'] == null ? SizedBox() :TextButton(
                onPressed: () async {
                  if(await canLaunch(sellerResult['profile']['url'])){
                    await launch(sellerResult['profile']['url']);
                  }
                  else{
                    throw 'Could not launch ${sellerResult['profile']['url']}';
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.link_outlined),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(ucFirst(sellerResult['profile']['url']),
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

    SizedBox(
                height: 700,
                child: ListView.builder(
                  itemCount: sellerResult['catItems'].length,
                  itemBuilder: (context , index){
                    return
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(ucFirst(sellerResult['catItems'][index]['name']),
                              style: TextStyle(
                                color: Color(0xffD60024),fontWeight: FontWeight.w600,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          ////
                          ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: sellerResult['catItems'][index]['items'].length,
                            itemBuilder:(context , index1){
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (context) =>ShowItemPage(itemDetails: sellerResult['catItems'][index]['items'][index1],)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0,1.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      //border: Border.all(color: Colors.red),
                                    ),
                                    child: Center(
                                      child: ListTile(
                                        leading: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: 60,
                                              minHeight: 80,
                                              maxHeight: 140,
                                              maxWidth: 120,
                                            ),
                                            child: Image.network(sellerResult['catItems'][index]['items'][index1]['image'], fit: BoxFit.cover,)),
                                        title: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(ucFirst(sellerResult['catItems'][index]['items'][index1]['name']),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w700),),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(ucFirst(sellerResult['catItems'][index]['items'][index1]['description'], ),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black26, fontSize: 15.0),),
                                        ),
                                        trailing: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            child: Text("Rs. "+sellerResult['catItems'][index]['items'][index1]['price'].toString(), style: TextStyle(
                                              color: Colors.blue,
                                            ),),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );//categoryItem[index]['image']
                            },
                          ),
                          ////
                        ],
                      );
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ): SpecialSpinner(),
    );
  }

  sellerProfile(int sellerID) async {
    sellerResult={};
    var res= await CallApi().postData({'id':sellerID},'/sellerShowProfile');
    var body =json.decode(res.body);
    print(body[0].toString());
    if(res.statusCode == 200){
      setState(() {
        sellerResult = body;
      });
      print(sellerResult.toString());
      executed = true;
    }
  }

}
