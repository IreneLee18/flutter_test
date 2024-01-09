import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/meals/models/meal.dart';

// Provider: 純資料
// final mealsProvider = Provider((ref) {
//   return meals;
// });

// 什麼資料要透過 StateNotifier 來控管
// 範例：<List<Meal>> 要透過 StateNotifier 來控管
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // initial data
  FavoriteMealsNotifier() : super([]);

  Map<String, bool> toggleStatus(Meal meal) {
    // flutter_riverpod：不允許編輯任何的值，必須始終都要創新得，因此不能使用 add、remove
    final isInclude = state.contains(meal);
    if (isInclude) {
      state = state.where((item) => item.id != meal.id).toList();
      return {meal.title: false};
    } else {
      state = [...state, meal];
      return {meal.title: true};
    }

    // flutter_riverpod：不允許編輯任何的值，必須始終都要創新得，因此不能使用 add、remove
    // final isInclude = _favoritesMeals.contains(meal);
    // setState(() {
    //   if (isInclude) {
    //     _favoritesMeals.remove(meal);
    //     _showStatusMessage('💔 ${meal.title} is no longer favorite.');
    //   } else {
    //     _favoritesMeals.add(meal);
    //     _showStatusMessage('💖 ${meal.title} is favorite.');
    //   }
    // });
  }
}

// <Notifier, Notifier產生得數據>
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
        (ref) => FavoriteMealsNotifier());
