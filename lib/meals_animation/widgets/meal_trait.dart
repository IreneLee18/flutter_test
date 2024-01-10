import 'package:flutter/material.dart';

class MealTrait extends StatelessWidget {
  const MealTrait({required this.label, required this.icon, super.key});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return (Row(
      children: [
        Icon(
          icon,
          size: 22,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        const SizedBox(width: 12),
      ],
    ));
  }
}
