import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:f_select_store/components/app_dialog.dart';
import 'package:f_select_store/pages/login/login_service.dart';
import 'package:f_select_store/pages/stations/station.dart';

class LoginController extends GetxController {
  var dataSource = LoginService();

  TextEditingController mobileNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  void login() async {
    mobileNumber.text = "+639998520424";
    password.text = "111111";
    var authenticated;
    var responseBody;
    
    if(mobileNumber.text.isEmpty || password.text.isEmpty || mobileNumber.text.isBlank || password.text.isBlank){
      CustomDialog.errorDialog("Log In Failed", "Please enter your mobile number and password");
      return;
    }

    if(mobileNumber.text.isNotEmpty && password.text.isNotEmpty){
      authenticated = await dataSource.getAuthenication(mobileNumber.text, password.text);
      responseBody = jsonDecode(authenticated.body);
    }
    
    if(authenticated.statusCode == 201){
       Get.defaultDialog(
        title: "Log In Success",
        content:  Center(child: Text(responseBody['message'], textAlign: TextAlign.center),),
        onWillPop: () {
          Get.back();
          navigateToNextPage();
        }
      );
    } else {
      CustomDialog.errorDialog("Log In Failed", authenticated.statusCode.toString() + ": " + responseBody['message']);
    }
  }

  navigateToNextPage(){

    Get.to(() =>LandingPage());
  }


  @override
    void onInit() {
      // TODO: implement onInit
      super.onInit();
    }

}