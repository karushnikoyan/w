import 'package:flutter/material.dart';

abstract class AppColors{

  static const primary = Colors.black;
  static const contrast = Colors.white;

  static const background = Color(0xCDECEFEB);
  static const content = Color(0x848AA7CE);
  static const greenBackGround = Color(0xF2DBE8DB);
  static const customRed = Color(0xFFE34E4E);
  static const customGreen = Color(0x864BFF00);
  static const modalBackground = Color(0x867B8379);
  static const snackBarBackground = Color(0x452F2D2D);
  static const workoutButton = Color(0xBE7394FF);
  static const exerciseBackground = Color(0x56BF82E7);

  static const cancel = Color.fromRGBO(209, 76, 60,1);
  static const apply = Color.fromRGBO(127, 251, 100,1);
  // static const exerciseBackgroundDark = Color(0x74B758FC);




  static const cRed  = Color.fromRGBO(136, 37, 31,1);
  static const cOcean  = Color.fromRGBO(36, 87, 110,0.5);
  static const cYellow  = Color.fromRGBO(145, 138, 42,0.5);
  static const cGreen  = Color.fromRGBO(44, 104, 64,0.5);
  // static const cOrange  = Color.fromRGBO(98, 53, 32,0.5);
  static const cOrange  = Color.fromRGBO(175, 147, 120,0.4);
  static const cGray  = Color.fromRGBO(29, 14, 13,0.8);


}


abstract class AppTextStyle{

  static const defaultTextStyle = TextStyle(fontSize: 18.0,color: AppColors.primary,);
  static const titleSmall = TextStyle(fontSize: 24.0,color: AppColors.primary,fontWeight: FontWeight.w700);
  static const titleSmallWhite = TextStyle(fontSize: 24.0,color: Colors.white60,fontWeight: FontWeight.w700);
  static const titleLarge = TextStyle(fontSize: 30.0,color: AppColors.primary,fontWeight: FontWeight.w600, letterSpacing: 1);

  static const facts = TextStyle(fontSize: 22.0,color: AppColors.primary,fontWeight: FontWeight.w400,letterSpacing: 1);



  static const itemTextStyle = TextStyle(fontSize: 22 ,fontWeight: FontWeight.bold,color: Colors.white60);

}

abstract class AppTheme{
  static BoxShadow shadow = BoxShadow(
    offset: const Offset(0, 4),
    blurRadius: 4,
    color: const Color(0xFF030303).withOpacity(0.8),
  );
}

abstract class AppBorderRadius{
  static const BorderRadius defaultBorderRadius = BorderRadius.all(Radius.circular(20.0));
}