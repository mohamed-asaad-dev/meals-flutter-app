import 'package:flutter/material.dart';

class MealItemTraits extends StatelessWidget {
  const MealItemTraits({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: Colors.white),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
