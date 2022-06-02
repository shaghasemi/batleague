import 'package:flutter/material.dart';

showSnack(BuildContext context, String text, {Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: color ?? Colors.blueGrey,
    ),
  );
}
