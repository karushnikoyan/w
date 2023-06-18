
import 'package:flutter/material.dart';

import '../../../../core/utils/style.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hintTitle;
  final Function(String)? onSubmitted;

  TextFieldCustom({required this.controller,required this.hintTitle,this.onSubmitted } );



  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      style: TextStyle(color: Colors.white60),
      onSubmitted: onSubmitted,

      decoration: InputDecoration(
          fillColor: AppColors.cOrange,
          filled: true,
          hintText: hintTitle,
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0),
              borderRadius: BorderRadius.circular(10.0))),
    );
  }
}
