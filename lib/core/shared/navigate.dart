import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigate({required BuildContext context, required Widget screen}) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ));
}

void navigateWithoutBack(
    {required BuildContext context, required Widget screen}) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ));
}
