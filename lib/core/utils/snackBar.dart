import 'package:flutter/material.dart';
import 'package:wo/core/utils/style.dart';

void showSnackBar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message,style: TextStyle(color: color,fontSize: 16.0),),
    backgroundColor: AppColors.snackBarBackground,
    elevation: 0,
    duration: const Duration(seconds: 2),
    action: SnackBarAction(label: "OK", onPressed: (){},),
  ));
}