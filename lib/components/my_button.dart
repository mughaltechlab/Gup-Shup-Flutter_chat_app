import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String? btnName;
  final Function()? onTap;
  // final Color btncolor;
  final Color btnNamecolor;
  final LinearGradient linearGradient;

  const MyButton({
    super.key,
    required this.btnName,
    required this.onTap,
    // required this.btncolor,
    required this.btnNamecolor,
    required this.linearGradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: linearGradient,
        ),
        child: Center(
            child: Text(
          btnName!,
          style: TextStyle(
            letterSpacing: 2.0,
            color: btnNamecolor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
