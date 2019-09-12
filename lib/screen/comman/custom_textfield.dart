import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final label;
  final icon;
  final obscureText;
  final controller;

  CustomTextField({Key key, this.label, this.icon, this.obscureText,this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(labelText: label, suffixIcon: Icon(icon)),
      ),
    );
  }
}
