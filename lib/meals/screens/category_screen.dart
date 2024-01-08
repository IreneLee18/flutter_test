import 'package:flutter/material.dart';
import 'package:test/meals/data/category.dart';
import 'package:test/meals/data/meal.dart';
import 'package:test/meals/models/category.dart';
import 'package:test/meals/models/meal.dart';
import 'package:test/meals/screens/filters_screen.dart';
import 'package:test/meals/screens/meals_screen.dart';
import 'package:test/meals/widgets/category_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    required this.filters,
    required this.onChangeFavorite,
    super.key,
  });
  final Map<Filter, bool> filters;
  final void Function(Meal meal) onChangeFavorite;

  void _selectedCategory({
    required BuildContext context,
    required Category category,
  }) {
    List<Meal> mealsData = meals
        .where((meal) => meal.categories.contains(category.id))
        .where((meal) {
      if (filters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (filters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (filters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    // 兩種切換 router
    // 寫法一：
    // Navigator.push(context, route);
    // 寫法二：
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        title: category.title,
        meals: mealsData,
        onChangeFavorite: onChangeFavorite,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Categories'),
      // ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // 一行幾個子元素
          crossAxisCount: 2,
          // 子元素寬高比例：子元素的寬度是高度的1.5倍
          childAspectRatio: 1.5,
          // 水平間距
          crossAxisSpacing: 20,
          // 垂直間距
          mainAxisSpacing: 20,
        ),
        children: [
          ...categories.map(
            (category) => CategoryItem(
              category: category,
              onSelected: _selectedCategory,
            ),
          )
        ],
      ),
    );
  }
}
