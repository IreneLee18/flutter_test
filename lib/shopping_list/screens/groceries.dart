import 'package:flutter/material.dart';
import 'package:test/shopping_list/models/grocery_item.dart';
import 'package:test/shopping_list/screens/NewItem.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() {
    return _GroceriesState();
  }
}

class _GroceriesState extends State<GroceriesScreen> {
  final _groceriesList = [];

  void _onNewItem() async {
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

  _onDelete(GroceryItem grocery) {
    int _index = _groceriesList.indexOf(grocery);
    _groceriesList.remove(grocery);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 10),
        content: Text('Delete Grocery: ${grocery.name}'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _groceriesList.insert(_index, grocery);
            });
          },
        ),
      ),
    );
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
      body: _groceriesList.isNotEmpty
          ? ListView.builder(
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
            )
          : const Center(
              child: Text(
                'Please add a new grocery....',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
    );
  }
}
