import 'package:flutter/material.dart';

class GroupBox extends StatelessWidget {
  final String title;
  final double groupBoxWidth;

  const GroupBox({super.key, required this.title, required this.groupBoxWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: groupBoxWidth,
      decoration: BoxDecoration(
        color: Colors.yellow[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
