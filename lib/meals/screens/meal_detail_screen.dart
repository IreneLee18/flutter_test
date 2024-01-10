import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/meals/models/meal.dart';
import 'package:test/meals/providers/favorites_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    required this.meal,
    super.key,
  });

  final Meal meal;

  @override
  // WidgetRef ref：負責用來監聽 Provider
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteMealsProvider).contains(meal);
    return (Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // 使用 read 而不使用 watch，是因為我不想用來監聽 Provider 的值，我只是想執行他的韓式而已
              final result =
                  ref.read(favoriteMealsProvider.notifier).toggleStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  content: Text(result.values.first
                      ? '💖 ${result.keys.first} is favorite.'
                      : '💔 ${result.keys.first} is no longer favorite.'),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              // child: Icon(isFavorite ? Icons.star : Icons.star_border),
              // 這時會發現不會有任何變化，因為 Flutter 他看的是外面的 Icon Widget 他不知道裡面的Icons 已經變化了，所以我們必須加上 Key 讓 Flutter 知道有變化
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
              transitionBuilder: (child, animation) => RotationTransition(
                // turns: animation,
                // 預設寫法，所以動畫值會是 0 - 1
                turns: Tween<double>(
                  begin: 0.8,
                  end: 1.0,
                ).animate(animation),
                child: child,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              'Ingredients',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 16),
            ...meal.ingredients.map(
              (ingredient) => Text(
                ingredient,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Steps',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 16),
            ...meal.steps.map(
              (step) => Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
