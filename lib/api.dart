import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CallApi{
  final String _url = 'http://10.0.2.2:8000/';

  postData(data, apiUrl) async {
    Uri fullUrl = Uri.parse(_url + apiUrl + await _getToken());

    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );

  }
  getData(apiUrl) async {
    Uri fullUrl = Uri.parse(_url + apiUrl + await _getToken());
    var resp=await http.get(
        fullUrl,
        headers: _setHeaders()
    );
    if (resp.statusCode == 200) {
      String data = resp.body;
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
    return '?token=$token';
  }
  getCSRF()
  async {
    var CSRF=await CallApi().getData('getSessionToken');
    print('In func:'+CSRF.toString());
    /*SharedPreferences localStorage = await SharedPreferences.getInstance();
     localStorage.setString('CSRF', CSRF);*/
    return CSRF;
  }
}