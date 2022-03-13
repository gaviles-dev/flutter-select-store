import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  FormTextField({
    Key key,
    @required this.controller,
    @required this.hintText, 
    this.textCapitalization = TextCapitalization.none, 
    this.keyboardType, 
    this.inputFormatters, 
    this.labelText, 
    this.enabled, 
    this.maxLength, 
    this.onChange, 
    this.borderColor = const Color(0xFFEFEFEF),
    this.focusNode,
    this.onTap,
    this.onSubmitted,
    this.fontSize = 15.0,
    this.readOnly = false,
    this.contentPadding = const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 20.0),
    this.obscureText = false
    });

  TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final String hintText;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final List inputFormatters;
  final String labelText;
  final bool enabled;
  final Function(String) onChange;
  final int maxLength;
  final Color borderColor;
  final FocusNode focusNode;
  final VoidCallback onTap;
  final double fontSize;
  final EdgeInsetsGeometry contentPadding;
  final bool readOnly;
  bool obscureText;

  @override
  _FormTextFieldState createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  int height = 40;
  bool isValidated = true;
  TextEditingController _controller;

  void _toggleObscureText(){
    setState(() {
      _controller = new TextEditingController(text: widget.labelText);
      widget.controller = _controller;
      widget.obscureText = !widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isValidated ? 40 : 70,
      margin: const EdgeInsets.only(top:10),
      width: MediaQuery.of(context).size.width-(MediaQuery.of(context).size.width*0.2),
      child: TextFormField(
        readOnly: widget.readOnly,
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        style: TextStyle(fontSize: widget.fontSize),
        controller: widget.controller,
        textCapitalization: widget.textCapitalization,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        enableInteractiveSelection: false,
        enabled: widget.enabled,
        onChanged: widget.onChange,
         validator: (value) {
          if (value == null || value.isEmpty) {
            setState(() => isValidated = false);
            return widget.labelText + ' is a required field';
          }
          return null;
        },
        onFieldSubmitted: widget.onSubmitted,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          filled: true,
          // fillColor: Color(0xFFEFEFEF),
          fillColor: Colors.white,
          hintText: widget.hintText,
          counterText: "",
          labelText: widget.labelText,
          labelStyle: TextStyle(height: 1),
          contentPadding: widget.contentPadding,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: BorderSide(color: widget.borderColor)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: BorderSide(color: widget.borderColor)),
          // suffixIcon: IconButton(icon: widget.obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility), onPressed: _toggleObscureText)
        ),
      ),
    );
  }
}