import 'package:flutter/material.dart';

class HallButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onClick;

  const HallButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 2 - 20,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.grey[700],
            ),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}
