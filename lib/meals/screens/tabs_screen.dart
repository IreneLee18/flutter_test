import 'package:flutter/material.dart';
import 'package:test/meals/models/meal.dart';
import 'package:test/meals/screens/category_screen.dart';
import 'package:test/meals/screens/filters_screen.dart';
import 'package:test/meals/screens/meals_screen.dart';
import 'package:test/meals/widgets/drawer.dart';

const initFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  final List<Meal> _favoritesMeals = [];
  Map<Filter, bool> _filters = initFilters;

  void _showStatusMessage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(msg),
      ),
    );
  }

  void _setFavorites(Meal meal) {
    final isInclude = _favoritesMeals.contains(meal);
    setState(() {
      if (isInclude) {
        _favoritesMeals.remove(meal);
        _showStatusMessage('💔 ${meal.title} is no longer favorite.');
      } else {
        _favoritesMeals.add(meal);
        _showStatusMessage('💖 ${meal.title} is favorite.');
      }
    });
  }

  _selectedPage(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }

  void _onSelectedScreen(String screen) async {
    Navigator.pop(context);
    if (screen == 'Filters') {
      final result = await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
            builder: (ctx) => FiltersScreen(currentFilters: _filters)),
      );
      setState(() {
        _filters = result ?? initFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget body = _selectedIndex == 0
        ? CategoryScreen(
            filters: _filters,
            onChangeFavorite: _setFavorites,
          )
        : MealsScreen(
            meals: _favoritesMeals,
            onChangeFavorite: _setFavorites,
          );
    final String title = _selectedIndex == 0 ? 'Categories' : 'Favorites';

    return (Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MainDrawer(onSelectedScreen: _onSelectedScreen),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        // 切換 tab 函式：取得到目前點擊的 tab index
        onTap: _selectedPage,
        // 切換 tab index：用 onTap 取得到的目前當下的 index ，來設定現在的 tab index 是多少
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    ));
  }
}
