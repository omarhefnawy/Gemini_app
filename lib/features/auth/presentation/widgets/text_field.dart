import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool obscure;
  final TextEditingController controller;
  final TextInputType keyboared;
  final FormFieldValidator validator;
  final String text;
  CustomTextField(
      {required this.text,
      required this.controller,
      required this.keyboared,
      required this.obscure,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscure,
      controller: controller,
      keyboardType: keyboared,
      decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 20, color: Colors.red.shade900),
          contentPadding: EdgeInsets.all(20),
          filled: true,
          fillColor: Colors.grey[500],
          labelText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelStyle: TextStyle(color: Colors.grey[800], fontSize: 20)),
    );
  }
}
