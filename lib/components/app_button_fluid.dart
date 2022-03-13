import 'package:flutter/material.dart';
import 'package:f_select_store/constants/constants.dart';

class FormButtonFluid extends StatelessWidget {
  const FormButtonFluid({ 
    Key key, 
    @required this.onPressed,
    @required this.label
  }) : super(key: key);

  final Function onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: 300,
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(ConfigTheme.textLight),
          backgroundColor: MaterialStateProperty.all<Color>(ConfigTheme.primary)
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}