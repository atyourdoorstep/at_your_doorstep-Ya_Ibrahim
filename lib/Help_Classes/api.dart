import 'dart:async';
import 'dart:convert';
import 'package:at_your_doorstep/Help_Classes/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
class CallApi{
  // final String _url = 'http://127.0.0.1:8000/api';//for web
  // final String _url = 'http://10.0.2.2:8000/api';//for emulator
  final String _url = 'http://atyourdoorstep-pk.herokuapp.com/api';//for heroku
  //  final String _url = 'http://192.168.100.6:8000/api';//for local



  postData(data, apiUrl) async {
    Uri fullUrl = Uri.parse(_url + apiUrl + await _getToken());
    var resp=await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
    return resp;
  }
  getData(apiUrl) async {
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
  uploadFile(file,apiUrl)
  async {
    Dio dio = new Dio();
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      // 'token':,
      "image": await MultipartFile.fromFile(file.path, filename:fileName),
    });
    var response = await dio.post(_url + apiUrl + await _getToken(), data: formData);
    var body=response.data;
    print("success: "+body['success'].toString());
    print("api response: "+body.toString());
    return response;
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
}