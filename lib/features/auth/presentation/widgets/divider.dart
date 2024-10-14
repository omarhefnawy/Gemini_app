import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget divider({required String text}) {
  return Row(
    children: [
      Expanded(
        child: Divider(
          thickness: .5,
          color: Colors.grey[900],
        ),
      ),
      Text(
        text,
        style: TextStyle(
            fontSize: 20, color: Colors.grey[900], fontWeight: FontWeight.bold),
      ),
      Expanded(
        child: Divider(
          thickness: .5,
          color: Colors.grey[900],
        ),
      ),
    ],
  );
}
