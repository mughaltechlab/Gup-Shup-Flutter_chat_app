import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String sectionTitle, sectionDetail;
  final void Function()? onTap;
  const MyTextBox({
    super.key,
    required this.sectionTitle,
    required this.sectionDetail,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, bottom: 15),
      margin: const EdgeInsets.all(20).copyWith(bottom: 0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // section title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionTitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              // setting button
              IconButton(
                onPressed: onTap,
                icon: const Icon(Icons.settings),
              ),
            ],
          ),

          // section detail
          Text(
            sectionDetail,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}
