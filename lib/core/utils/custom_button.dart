import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  const CustomButton({Key? key,required this.onPressed,required this.child,
  this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  ElevatedButton(onPressed: onPressed,
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:  MaterialStateProperty.all<Color>(backgroundColor ?? Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),

              ),
            )
        ),
        child: Container(
          alignment: Alignment.center,
          width: size.width * 0.7,
          height: 50.0,
          child: child,
        ));
  }
}
