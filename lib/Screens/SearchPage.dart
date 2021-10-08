import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:at_your_doorstep/Help_Classes/api.dart';
import 'package:at_your_doorstep/Screens/LandingPages/showItemPage.dart';
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
  var searchItem1;

  bool executed= false;
  bool executed1 = false;
  late String searchWord;

  @override
  void initState() {
    executed= false;
    executed1= false;

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
              hintText:  ' Search by services ,provider\'s name',
            ),
            obscureText: false,
            controller: searchController,
            onChanged: (value){
              print(value);
              setState(() {
                searchWord = value;
              });
             if(value != ''){
               getSearchItems(value);
               getSearchServiceProvider(value);
             }
            },
            onSubmitted: (value){
              if(value != ''){
                getSearchItems(value);
                getSearchServiceProvider(value);
              }
            },
          ),
          centerTitle: true,
          titleSpacing: 2.0,
        ),
      ),
      body: executed == true && executed1 == true ? SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Search Results of : \' $searchWord \'".toString(), style: TextStyle(
                color: Colors.black26,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Product and Services", style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),),
            ),
            searchItem.length>0 ? SizedBox(
              height: searchItem.length <= 1  ? 100 : 300,
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
                              trailing: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  child: Text("Rs. "+searchItem[index]['price'].toString(), style: TextStyle(
                                    color: Colors.blue,
                                  ),),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );//categoryItem[index]['image']
                },
              ),
            ): ListTile(title: Center(child: Text("No product and Service found")),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Service Providers", style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),),
            ),
            ////
            searchItem1.length>0 ? SizedBox(
              height: searchItem1.length <= 1  ? 100 : 300,
              child: ListView.builder(
                itemCount: searchItem1.length,
                itemBuilder:(context , index){
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
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
                           title: Text(ucFirst(searchItem1[index]['user_name']),
                             overflow: TextOverflow.ellipsis,
                             style: TextStyle(
                                 color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w700),),
                            trailing: searchItem1[index]['is_active'] == 1 ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Available", style: TextStyle(
                                color: Colors.green,
                              ),),
                            ):Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Not Available", style: TextStyle(
                                color: Colors.red,
                              ),),
                            ),

                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ): ListTile(title: Center(child: Text("No Service Provider Found")),),
            ////
          ],
        ),
      ): Container(),
    );
  }

  getSearchItems(var searchWord) async {
    searchItem={};
    var res= await CallApi().getData('/searchItem?search=$searchWord' );
    var body =json.decode(res.body);
    if(res.statusCode == 200){
      setState(() {
        searchItem = body['result'];
      });
      executed = true;
    }
  }

  getSearchServiceProvider(var searchWord) async {
    searchItem1={};
    var res= await CallApi().getData('/searchSeller?search=$searchWord' );
    var body =json.decode(res.body);
    if(res.statusCode == 200){
      setState(() {
        searchItem1 = body['result'];
        print("loooo :"+searchItem1.toString());
      });
      executed1 = true;
    }
  }

}
