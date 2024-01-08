import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({required this.fill, super.key});
  final double fill;

  @override
  Widget build(BuildContext context) {
    final isDarkModal =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: (FractionallySizedBox(
          // 指定 bar 高度
          heightFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              color: isDarkModal
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        )),
      ),
    );
  }
}
