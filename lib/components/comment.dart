import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const Comment({
    super.key,
    required this.text,
    required this.user,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // comment text
          Text(
            text,
            style: const TextStyle(
              letterSpacing: 1.7,
              color: Colors.black,
              fontSize: 16,
            ),
          ),

          // gap
          const SizedBox(height: 10),

          // user. time
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const Text(" . "),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
