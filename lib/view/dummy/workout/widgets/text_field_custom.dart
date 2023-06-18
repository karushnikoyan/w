import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/style.dart';

class TextFieldCustom extends StatelessWidget {

  TextFieldCustom({@required this.controller,@required this.hintTitle});

  var controller;
  var hintTitle;

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      style: TextStyle(color: Colors.white60),
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
