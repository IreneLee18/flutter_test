import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/meals/data/meal.dart';

// Provider: 純資料
final mealsProvider = Provider((ref) {
  return meals;
});