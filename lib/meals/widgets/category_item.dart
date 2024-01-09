import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/meals/models/category.dart';

class CategoryItem extends ConsumerWidget {
  const CategoryItem({
    required this.category,
    required this.onSelected,
    super.key,
  });

  final Category category;
  final Function({
    required BuildContext context,
    required WidgetRef ref,
    required Category category,
  }) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // InkWell & GestureDetector 都是一些 EventListener
    // return GestureDetector(
    return InkWell(
      onTap: () {
        onSelected(
          context: context,
          ref: ref,
          category: category,
        );
      },
      // 手勢功能的動畫效果的顏色
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
