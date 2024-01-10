import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/meals/data/category.dart';
import 'package:test/meals/models/category.dart';
import 'package:test/meals/models/meal.dart';
import 'package:test/meals/providers/filter_provider.dart';
import 'package:test/meals/screens/meals_screen.dart';
import 'package:test/meals/widgets/category_item.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({
    super.key,
  });

  void _selectedCategory({
    required BuildContext context,
    required WidgetRef ref,
    required Category category,
  }) {
    final filtersMeals = ref.watch(filterMealsProvider);
    List<Meal> mealsData = filtersMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        title: category.title,
        meals: mealsData,
      ),
    ));
  }

  @override
  ConsumerState<CategoryScreen> createState() {
    return _CategoryScreenState();
  }
}

class _CategoryScreenState extends ConsumerState<CategoryScreen>
    with SingleTickerProviderStateMixin {
  // late：創建class沒有值，但初次使用時會有值（用於聲明變數的延遲初始化）
  late AnimationController _animationController;

  // 初始化時不能創建 animation 因此需要使用 initState 創建
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      // 實現 TickerProvider 的
      vsync: this,
      duration: const Duration(milliseconds: 300),
      // 動畫值的範圍
      lowerBound: 0,
      upperBound: 1,
    );
    // 一定要啟動動畫，否則動畫不會動
    _animationController.forward();
  }

  // 最後一定要記得刪除 animation
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          ...categories.map(
            (category) => CategoryItem(
              category: category,
              onSelected: widget._selectedCategory,
            ),
          )
        ],
      ),
      // builder：當動畫有變化時都會被調用，但因為我只想改變我的動畫而不所有的 UI
      //          所以我可以將我的 UI 當作 child 參數傳進去，進行效能優化
      builder: (context, child) => SlideTransition(
        // Tween 動畫：
        // Tween：希望動畫在這兩個設定中間做變化，舉例：Y軸從 30% 移動到Y軸 0%
        // 0: 0% ,0.3: 30%, 1: 100% ...以此類推

        // 寫法一：使用 _animationController.drive 來整合 Tween
        // position: _animationController.drive(
        //   Tween(
        //     begin: const Offset(0, 0.3),
        //     end: const Offset(0, 0),
        //   ),
        // ),
        // 寫法二：使用 CurvedAnimation 指定動畫曲線
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          // CurvedAnimation：用來改變動畫曲線
          CurvedAnimation(
            // parent：指定的動畫 controller
            parent: _animationController,
            // curve：指定的動畫曲線
            curve: Curves.bounceInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
