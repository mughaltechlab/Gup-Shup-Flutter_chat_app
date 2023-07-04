import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Color? color;
  final Color? txtColor;
  final void Function()? onTap;
  const MyListTile({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
    this.color,
    this.txtColor,
  });

  // color

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: ListTile(
        leading: Icon(
          iconData,
          color: color ?? Colors.white,
        ),
        onTap: onTap,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: txtColor ?? Colors.grey.shade200,
            fontWeight: FontWeight.bold,
            letterSpacing: 10,
          ),
        ),
      ),
    );
  }
}
