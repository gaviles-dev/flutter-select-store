import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginService {

  getAuthenication(String mobile, String pass) async {
    String url = "https://staging.api.locq.com/ms-profile/user/login";
    Map<String, String> headers = {"Content-type" : "application/json"};
    Map<String, String> body = {
      "mobileNumber" : mobile,
      "password" : pass,
      "profileType": "plc"
    };
    http.Response response;
    
    try{  
      response = await http.post(url, headers: headers, body: jsonEncode(body));
    }catch (e){
      Get.defaultDialog(
        title: "Log in failed",
        content: jsonDecode(response.body)['message']
      );
    }
    return response;
  }

}