import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context , String message) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.green,
    duration: Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}