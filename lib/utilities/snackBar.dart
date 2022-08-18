import 'package:coinbank/colors.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 1500),
      content: Text(
        text,
        style: TextStyle(
            fontFamily: "Nunito", color: LYellow, fontWeight: FontWeight.w700),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 10,
    ),
  );
}
