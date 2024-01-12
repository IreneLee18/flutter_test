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
  bool _isLoading = true;
  String? _errorMsg;
  List<GroceryItem> _groceriesList = [];

  void _loadItem() async {
    super.initState();
    try {
      final url = Uri.https(
        'testflutter-14d88-default-rtdb.firebaseio.com',
        'shopping-list.json',
      );
      final res = await http.get(url);
      if (res.statusCode == 200) {
        // 這裡防止當後端沒有資料時無法進入到下面的 Map 迴圈，而無法將 _isLoading 改成 false
        if (res.body == 'null') {
          setState(() {
            _isLoading = false;
          });
          return;
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
        setState(() {
          _isLoading = false;
          _groceriesList = loadedList;
        });
      }
    } catch (err) {
      setState(() {
        _errorMsg = 'Something wrong. Try again...';
      });
    }
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
    _loadItem();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text(
        'Please add a new grocery....',
        style: TextStyle(
          fontSize: 28,
        ),
      ),
    );

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (_errorMsg != null) {
      content = Center(
        child: Text(
          _errorMsg!,
          style: TextStyle(
            fontSize: 28,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      );
    }

    if (_groceriesList.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceriesList.length,
        itemBuilder: (ctx, i) => Dismissible(
          key: ValueKey(_groceriesList[i]),
          onDismissed: (direction) {
            _onDelete(_groceriesList[i]);
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
            title: Text(_groceriesList[i].name),
            leading: Container(
              width: 20,
              height: 20,
              color: _groceriesList[i].category.color,
            ),
            trailing: Text(_groceriesList[i].quantity.toString()),
          ),
        ),
      );
    }

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
      body: content,
    );
  }
}
