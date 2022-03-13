import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:f_select_store/constants/constants.dart';

class ConfigTextStyles {

  static TextStyle primary({textsize, textcolor, textweight}){
    return TextStyle(
      fontSize: textsize ?? 16,
      color: textcolor ?? ConfigTheme.textDark,
      fontWeight: textweight ?? FontWeight.normal
    );
  }

  static TextStyle header({textsize, textcolor, textweight}){
    return TextStyle(
      fontSize: textsize ?? 20,
      color: textcolor ?? ConfigTheme.textDark,
      fontWeight: textweight ?? FontWeight.bold
    );
  }

  static TextStyle subHeader({textsize, textcolor, textweight}){
    return TextStyle(
      fontSize: textsize ?? 14,
      color: textcolor ?? ConfigTheme.textDark,
      fontWeight: textweight ?? FontWeight.normal
    );
  }

  TextStyle disabled({textsize, textcolor, textweight}){
    textsize = textsize ;
    textcolor = textcolor ;
    textweight = textweight ;
    
    return TextStyle(
      fontSize: textsize ?? 16,
      color: textcolor ?? ConfigTheme.disableDark,
      fontWeight: textweight ?? FontWeight.normal
    );
  }
}