import 'package:flutter/material.dart';
import 'package:test/shopping_list/data/categories.dart';
import 'package:test/shopping_list/models/category.dart';
import 'package:test/shopping_list/models/grocery_item.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItemScreen> {
  // GlobalKey 主要用於在整個 widget 樹中的不同位置找到特定的 widget。它是一個全局性的 key，可以被用於跨 widget 樹的不同部分。
  // ValueKey 則是基於特定的值（通常是資料模型中的某個字段）來區分 widget。它是根據值的內容而不是全局位置來唯一識別 widget 的。
  final _formKey = GlobalKey<FormState>();
  Category _selectedCategory = categories[Categories.vegetables]!;
  String _name = '';
  int _quantity = 1;

  void _saveItem() {
    //  _formKey.currentState!.validate()，會幫我們找使用 _formKey 下的 widget 裡面有寫到 validator，並且驗證是否有錯誤
    // currentState: form 的狀態
    // _formKey.currentState!.validate(); 回傳值：
    // true: 所有驗證成功
    // false: 有驗證失敗
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(
        GroceryItem(
          id: DateTime.now().toString(),
          name: _name,
          quantity: _quantity,
          category: _selectedCategory,
        ),
      );
    }
  }

  void _reset() {
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          // 因為 Form 不會在狀態改變時重建一次，所以 Form 不會知道內部狀態有改變，因此需要使用 key，讓 Flutter 知道 Form 裡面狀態有改變
          key: _formKey,
          child: Column(
            children: [
              // Instead of TextField
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length > 50) {
                    return 'Must be between 1 and 50 character.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: '1',
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! < 1) {
                          return 'Must be valid positive number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _quantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                      items: categories.entries
                          .map(
                            (category) => DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    color: category.value.color,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(category.value.title),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _reset,
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: const Text('Add Item'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
