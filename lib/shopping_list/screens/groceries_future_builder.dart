// 不建議使用 ！！！！ Future Builder
// 當我們實際上是在同一個頁面加載數據，不推薦使用，因為我們只有在第一次 build 起來時取得資料
// 但當我們新增時，我們只是將資料放到 list 中，並沒有重新加載一次 所有的 List
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/shopping_list/data/categories.dart';
import 'package:test/shopping_list/models/grocery_item.dart';
import 'package:test/shopping_list/screens/NewItem.dart';
import 'package:http/http.dart' as http;

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() {
    return _GroceriesState();
  }
}

class _GroceriesState extends State<GroceriesScreen> {
  late Future<List<GroceryItem>> _loadedItem;
  List<GroceryItem> _groceriesList = [];

  Future<List<GroceryItem>> _loadItem() async {
    super.initState();
    final url = Uri.https(
      'testflutter-14d88-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );
    final res = await http.get(url);

    if (res.statusCode >= 400) {
      throw Exception(' Failed to fetch grocery items. Please try again...');
    }

    if (res.body == 'null') {
      return [];
    }
    final List<GroceryItem> loadedList = [];
    final Map<String, dynamic> jsonRes = json.decode(res.body);
    for (var item in jsonRes.entries) {
      // 去取得正確得 category.value
      final category = categories.entries
          .firstWhere(
              (element) => element.value.title == item.value['category'])
          .value;

      loadedList.add(GroceryItem(
        id: item.key,
        name: item.value['name'],
        quantity: item.value['quantity'],
        category: category,
      ));
    }
    return loadedList;
  }

  void _onNewItem() async {
    // 從上一頁拿回來的資料
    final result = await Navigator.push<GroceryItem>(
      context,
      MaterialPageRoute(
        builder: (ctx) => const NewItemScreen(),
      ),
    );

    if (result == null) return;
    setState(() {
      _groceriesList.add(result);
    });
  }

  _onDelete(GroceryItem grocery) async {
    final url = Uri.https(
      'testflutter-14d88-default-rtdb.firebaseio.com',
      'shopping-list/${grocery.id}.json',
    );
    int _index = _groceriesList.indexOf(grocery);

    setState(() {
      _groceriesList.remove(grocery);
    });

    final res = await http.delete(url);
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: Text('Delete Grocery: ${grocery.name}'),
          // action: SnackBarAction(
          //   label: 'Undo',
          //   onPressed: () {
          //     setState(() {
          //       _groceriesList.insert(_index, grocery);
          //     });
          //   },
          // ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Delete Fail! Try again!'),
        ),
      );
      setState(() {
        _groceriesList.insert(_index, grocery);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadedItem = _loadItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _onNewItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: _loadedItem,
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapShot.hasError) {
            return Center(
              child: Text(
                snapShot.error.toString(),
                style: TextStyle(
                  fontSize: 28,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            );
          }
          if (snapShot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Please add a new grocery....',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapShot.data!.length,
            itemBuilder: (ctx, i) => Dismissible(
              key: ValueKey(snapShot.data![i]),
              onDismissed: (direction) {
                _onDelete(snapShot.data![i]);
              },
              direction: DismissDirection.endToStart,
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    SizedBox(width: 16)
                  ],
                ),
              ),
              child: ListTile(
                title: Text(snapShot.data![i].name),
                leading: Container(
                  width: 20,
                  height: 20,
                  color: snapShot.data![i].category.color,
                ),
                trailing: Text(snapShot.data![i].quantity.toString()),
              ),
            ),
          );
        },
      ),
    );
  }
}
