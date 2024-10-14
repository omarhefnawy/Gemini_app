import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback press;
  final String text;
  CustomTextButton({required this.text, required this.press});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.blueAccent, borderRadius: BorderRadius.circular(20)),
      child: TextButton(
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
        ),
      ),
    );
  }
}
