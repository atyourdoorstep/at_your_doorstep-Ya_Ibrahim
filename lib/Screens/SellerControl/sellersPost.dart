import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Screens/SellerControl/editSellerPost.dart';
import 'package:flutter/material.dart';
class SellersPostList extends StatefulWidget {
  const SellersPostList({Key? key}) : super(key: key);

  @override
  _SellersPostListState createState() => _SellersPostListState();
}

class _SellersPostListState extends State<SellersPostList> {

  var categoryItem;
  bool executed = false;

  @override
  void initState() {
    executed = false;
    getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: executed? SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("YOUR POSTS", style:
                  TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              /////
              categoryItem.length >0 ? SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: categoryItem.length,
                  itemBuilder:(context , index){
                    return Padding(
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
                                child: CircleAvatar(
                                  //foregroundImage: NetworkImage(sampleImage,),
                                  child: Text((index+1).toString()),)), //Image.network(categoryItem[index]['image'], fit: BoxFit.cover,)
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(ucFirst(categoryItem[index]['name']),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w700),),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(ucFirst(categoryItem[index]['description'], ),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black26, fontSize: 15.0),),
                            ),
                            trailing: TextButton(
                              onPressed: () {

                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => EditPost(
                                          postId: categoryItem[index]['id'],
                                          itemDetails: categoryItem[index],
                                        )));

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Edit", style: TextStyle(
                                  color: Colors.blue,
                                ),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );//categoryItem[index]['image']
                  },
                ),
              ): ListTile(title: Center(child: Text("No Post Created Yet")),),
              /////
            ],
          ),
        ),
      ): SpecialSpinner(),
    );
  }
  getItems() async {
    categoryItem={};
    var res= await CallApi().postData({},'/sells' );
    var body =json.decode(res.body);
    if(res.statusCode == 200){
      setState(() {
        categoryItem = body['items'];
      });
      executed = true;
    }
  }
}
