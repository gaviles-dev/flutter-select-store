import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StationService {

  getStationList() async {
    String url = "https://staging.api.locq.com/ms-fleet/station?page=1&perPage=289";
    Map<String, String> headers = {"Content-type" : "application/json"};
    http.Response response;
    try{  
      response = await http.get(url, headers: headers,);
    }catch (e){
      Get.defaultDialog(
        title: "Fetch Data Failed",
        content: jsonDecode(response.body)['message']
      );
    }
    return response;
  }

}