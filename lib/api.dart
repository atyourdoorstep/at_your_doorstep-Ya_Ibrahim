import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CallApi{
  // final String _url = 'http://127.0.0.1:8000/api';//for web
  // final String _url = 'http://10.0.2.2:8000/api';//for emulator
  final String _url = 'http://test-at-your-door-step.herokuapp.com/api';//for heroku
  //  final String _url = 'http://192.168.100.6:8000/api';//for local



  postData(data, apiUrl) async {
    Uri fullUrl = Uri.parse(_url + apiUrl + await _getToken());
    //Uri fullUrl = Uri.parse(_url + apiUrl );
    var head=_setHeaders();
    //print('headers: '+head.toString());
    //head['X-CSRF-TOKEN']=await _getCurrentCSRF();
    //print('headers: '+head.toString());
    var resp=await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
    //print('Func resp: '+resp.body.toString());
    return resp;

  }
  getData(apiUrl) async {
    //Uri fullUrl = Uri.parse(_url + apiUrl + await _getToken());
    Uri fullUrl = Uri.parse(_url + apiUrl);
    var resp=await http.get(
        fullUrl,
        headers: _setHeaders()
    );
    if (resp.statusCode == 200) {
      String data = resp.body;
      //print('post resp: '+data.toString());
      return jsonDecode(data);
    } else {
      print(resp.statusCode);
    }

    return {'Error':'Failed to get Date from provided URL'};
  }




  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    // if(token!.isEmpty)
    //   {
    //     return '';
    //   }
    return '?token=$token';
  }
// _getCurrentCSRF() async{
//   SharedPreferences localStorage = await SharedPreferences.getInstance();
//   var CSRF = localStorage.getString('CSRF');
//   return CSRF;
// }
//  getCSRF()
//  async {
//    var CSRF=await CallApi().getData('getSessionToken');
//    print('In func:'+CSRF.toString());
//    return CSRF;
// }
// getSavedCSRF()
// async {
//   SharedPreferences localStorage = await SharedPreferences.getInstance();
//   String? x=localStorage.getString('CSRF');
//   print('Token after save:'+x!);
//   return x;
// }
}