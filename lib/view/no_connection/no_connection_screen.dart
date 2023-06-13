import 'package:flutter/material.dart';

import '../../core/utils/style.dart';


class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background ,
        body:Center(
          child:  Container(
            height: size.height * 0.3,
            width: size.width *0.7,
            decoration: BoxDecoration(
              color: AppColors.content,
                borderRadius: AppBorderRadius.defaultBorderRadius,
                boxShadow: [
                  AppTheme.shadow
                ]
            ),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: const [
                Text("Something went wrong \nor no internet connection",style: AppTextStyle.defaultTextStyle,),
                SizedBox(height: 20,),
                CircularProgressIndicator(color: AppColors.primary,)
              ],
            ),
          ),
        )

    );
  }
}
