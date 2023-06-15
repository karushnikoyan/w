import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CapsulWidget extends StatelessWidget {
  CapsulWidget( {required Widget child});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
      color : Colors.white60 ,
      borderRadius: BorderRadius.all(
          Radius.circular(30.0) //                 <--- border radius here
      ),
    ),


    );
  }

}
