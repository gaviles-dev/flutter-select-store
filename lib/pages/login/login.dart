import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:f_select_store/components/app_button_fluid.dart';
import 'package:f_select_store/components/app_text_field.dart';
import 'package:f_select_store/constants/constants.dart';
import 'package:f_select_store/constants/text_themes.dart';
import 'package:f_select_store/pages/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController lc = Get.put(LoginController());
    // Key login_email;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ConfigString.appBarTitle,
          style: ConfigTextStyles.primary(textcolor: ConfigTheme.textLight),
        ),
        backgroundColor: ConfigTheme.primary,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            FormTextField(
              // key: login_email,
              hintText: ConfigString.login_mobile_number,
              controller: lc.mobileNumber,
            ),
            FormTextField(
              hintText: ConfigString.login_password,
              controller: lc.password,
            ),
            FormButtonFluid(
              label: ConfigString.login_button,
              onPressed: () => lc.login(),
            )
          ],
        ),
      ),
    );
  }
}