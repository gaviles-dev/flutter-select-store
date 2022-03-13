import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static errorDialog(title, message){
    return Get.defaultDialog(
      title: title ?? 'An Error Occured',
      content: Center(child: Text(message ?? 'Please try to reload your app', textAlign: TextAlign.center),) 
    );
  }

  static successDialog(title, message){
    return Get.defaultDialog(
      title: title ?? 'Success',
      content: Center(child: Text(message ?? '', textAlign: TextAlign.center),) 
    );
  }
}