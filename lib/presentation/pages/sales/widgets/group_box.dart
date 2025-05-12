import 'package:flutter/material.dart';

class GroupBox extends StatelessWidget {
  final String title;

  const GroupBox({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.yellow[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
} 