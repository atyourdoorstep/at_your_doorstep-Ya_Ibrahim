import 'dart:convert';

import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/specialSpinner.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
import 'package:at_your_doorstep/Screens/showItemPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  var searchItem;
  bool executed= false;

  @override
  void initState() {
    executed= false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset("assets/atyourdoorstep1.png"),
          ),
          backgroundColor: Colors.white,
          title: TextField(
            decoration: InputDecoration(
              hintText:  'Search by services ,provider\'s name',
            ),
            obscureText: false,
            controller: searchController,
            onChanged: (value){
              print(value);
              getSearchItems(value);
            },
            onSubmitted: (value){
              print(value);
              getSearchItems(value);
            },
          ),
          centerTitle: true,
          titleSpacing: 2.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            executed? SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: searchItem.length,
                itemBuilder:(context , index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context) =>ShowItemPage(itemDetails: searchItem[index],)));
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0,1.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: 60,
                                    minHeight: 80,
                                  ),
                                  child: Image.network(searchItem[index]['image'], fit: BoxFit.cover,)),
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(ucFirst(searchItem[index]['name']),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w700),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );//categoryItem[index]['image']
                },
              ),
            ): SpecialSpinner(),
          ],
        ),
      ),
    );
  }

  getSearchItems(var searchWord) async {
    searchItem={};
    // print('/searchItem?search=$searchWord');
    // return ;
    var res= await CallApi().getData('/searchItem?search=$searchWord' );
    var body =json.decode(res.body);
    if(res.statusCode == 200){
      setState(() {
        searchItem = body['result'];
        print("loooo :"+searchItem.toString());
      });
      executed = true;
    }
  }

}
