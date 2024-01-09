import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/meals/providers/filter_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
//  // 初始化狀態，因為 widget.[變數/方法]只能用於 build 裡面，所以需要透過 initState 的方式使用
//   @override
//   void initState() {
//     super.initState();
//     _gluten = widget.currentFilters[Filter.glutenFree] ?? false;
//     _lactose = widget.currentFilters[Filter.lactoseFree] ?? false;
//     _vegetarian = widget.currentFilters[Filter.vegetarian] ?? false;
//     _vegan = widget.currentFilters[Filter.vegan] ?? false;
//   }

  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(filterProvider);
    final onChange = ref.read(filterProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectedScreen: (String screen) {
      //     Navigator.pop(context);
      //     if (screen == 'Meals') {
      //       // pushReplacement：使當前前往的頁面取代現在的頁面，所以不會有任何返回上一頁的頁面
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(builder: (ctx) => const TabsScreen()),
      //       );
      //     }
      //   },
      // ),
      body: PopScope(
        // canPop：當前頁面是否可以返回上一頁
        canPop: false,
        // onPopInvoked：當使用者嘗試返回時會調用的函式
        onPopInvoked: (didPop) async {
          // didPop：如果 didPop 為 true 表示已經調用返回上一頁了，因此無需做剩餘的步驟
          if (didPop) return;
          Navigator.of(context).pop();
          // 當離開此頁面時，將資料傳遞給上一頁的頁面
          // Navigator.of(context).pop(
          //   {
          //     Filter.glutenFree: _gluten,
          //     Filter.lactoseFree: _lactose,
          //     Filter.vegetarian: _vegetarian,
          //     Filter.vegan: _vegan,
          //   },
          // );
        },
        child: Column(children: [
          FilterItem(
            title: 'Gluten-free',
            subtitle: 'Only include gluten free meal.',
            value: filters[Filter.glutenFree]!,
            onChange: (status) {
              onChange.toggleStatus(Filter.glutenFree, status);
            },
          ),
          FilterItem(
            title: 'Lactose-free',
            subtitle: 'Only include lactose free meal.',
            value: filters[Filter.lactoseFree]!,
            onChange: (status) {
              onChange.toggleStatus(Filter.lactoseFree, status);
            },
          ),
          FilterItem(
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meal.',
            value: filters[Filter.vegetarian]!,
            onChange: (status) {
              onChange.toggleStatus(Filter.vegetarian, status);
            },
          ),
          FilterItem(
            title: 'Vegan',
            subtitle: 'Only include vegan meal.',
            value: filters[Filter.vegan]!,
            onChange: (status) {
              onChange.toggleStatus(Filter.vegan, status);
            },
          ),
        ]),
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  const FilterItem({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChange,
    super.key,
  });
  final String title;
  final String subtitle;
  final bool value;
  final Function(bool status) onChange;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChange,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}
