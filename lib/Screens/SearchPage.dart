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
          title: textfieldStyle(
            textHint: 'Search by services ,shop name',
            obscureText: false,
            //textLabel1: 'Search ',
            controllerText: searchController,
            onChange: (value){
              print(value);
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
}
