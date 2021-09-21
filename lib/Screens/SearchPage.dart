import 'dart:convert';

import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Help_Classes/textFieldClass.dart';
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
          children: [
          ],
        ),
      ),
    );
  }

  getSearchItems(var searchWord) async {
    searchItem={};
    var res= await CallApi().getData('/searchItem?search=$searchWord' );
    var body =json.decode(res.body);
    print(  body.toString());
    if(res.statusCode == 200){
      setState(() {
        searchItem = body;
        print("loooo "+searchItem.toString());
      });
      executed = true;
    }
  }

}
