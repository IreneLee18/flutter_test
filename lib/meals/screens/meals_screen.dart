import 'package:flutter/material.dart';
import 'package:test/meals/models/meal.dart';
import 'package:test/meals/screens/meal_detail_screen.dart';
import 'package:test/meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    this.title,
    required this.meals,
    required this.onChangeFavorite,
    super.key,
  });
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onChangeFavorite;

  void _description({
    required BuildContext context,
    required Meal meal,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealDetailScreen(
          meal: meal,
          onChangeFavorite: onChangeFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      // 呈現總共有多少個列表，一定要加！不然會報錯，因為它告訴 Flutter 要構建多少個列表項目（items）！
      itemCount: meals.length,
      itemBuilder: (ctx, i) => MealItem(
        meal: meals[i],
        onDescription: _description,
      ),
    );
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh... nothing here!',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 16),
            Text(
              title == null
                  ? 'Try add some meal!'
                  : 'Try selected a different category!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
