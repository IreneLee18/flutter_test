import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.onSave, super.key});
  final void Function(Expense expense) onSave;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // 必須手動儲存資料
  // String _title = '';
  // void _handleTitleChange(String inputValue) {
  //   _title = inputValue;
  // }

  // flutter 可以自動幫我們儲存資料
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _pickDate = DateTime.now();
  Category _selectedCategory = Category.work;

  void _datePicker() async {
    final today = DateTime.now();
    final firstDate = DateTime(today.year - 1, today.month, today.day);

    final pickDate = await showDatePicker(
      context: context,
      initialDate: _pickDate,
      firstDate: firstDate,
      lastDate: today,
    );

    setState(() {
      _pickDate = pickDate as DateTime;
    });
  }

  String formatterDate(DateTime date) =>
      formatDate(date, [yyyy, '/', mm, '/', dd]);

  void _showDialog() {
    if (Platform.isIOS) {
      // IOS 長相的 dialog
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text(
            'Invalid Input!',
            style: TextStyle(color: Colors.red[300]),
          ),
          content: const Text(
              'Please make sure a valid title and amount was entered.'),
          actions: [
            TextButton(
                onPressed: () {
                  // 關掉錯誤訊息視窗，傳入的ctx是錯誤訊息的
                  Navigator.pop(ctx);
                },
                child: const Text('OK'))
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Invalid Input!',
            style: TextStyle(color: Colors.red[300]),
          ),
          content: const Text(
              'Please make sure a valid title and amount was entered.'),
          actions: [
            TextButton(
                onPressed: () {
                  // 關掉錯誤訊息視窗，傳入的ctx是錯誤訊息的
                  Navigator.pop(ctx);
                },
                child: const Text('OK'))
          ],
        ),
      );
    }
  }

  void _onSubmit() {
    final double? amount = double.tryParse(_amountController.text);
    // tryParse('Hello') => null
    // tryParse('1.22') => 1.22

    final amountIsInvalid = amount == null || amount <= 0;

    if (_titleController.text.trim().isEmpty || amountIsInvalid) {
      _showDialog();
      return;
    }

    widget.onSave(
      Expense(
          title: _titleController.text,
          amount: amount,
          date: _pickDate,
          category: _selectedCategory),
    );
    // 關掉新增記帳視窗，傳入的context是記帳視窗的
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 橫的畫面：使鍵盤不會擋住畫面，所以要將畫面變成滾動模式(SingleChildScrollView)
    //         並加上鍵盤的高度來調整padding
    final double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    // 另外一種的檢查 最大最小寬高
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      // 橫的畫面：高度會失效，所以要加上 SizedBox 將高度撐開
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            // 因為 modal 撐滿整個畫面，所以有些東西會被遮蓋，這時需要將 padding top 增加多一點
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          // 手動儲存資料
                          // onChanged: _handleTitleChange,
                          // flutter 自動儲存資料
                          controller: _titleController,
                          decoration:
                              const InputDecoration(label: Text('Title')),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    // 手動儲存資料
                    // onChanged: _handleTitleChange,
                    // flutter 自動儲存資料
                    controller: _titleController,
                    decoration: const InputDecoration(label: Text('Title')),
                    maxLength: 50,
                  ),
                if (width >= 600) const SizedBox(height: 16),
                if (width >= 600)
                  Row(
                    children: [
                      IconButton(
                        onPressed: _datePicker,
                        icon: const Icon(Icons.calendar_month),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Selected Date',
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(formatterDate(_pickDate)),
                        ],
                      ),
                      const Spacer(),
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                _selectedCategory = value;
                              }
                            });
                          })
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: _datePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Selected Date',
                                  style: TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 4),
                                Text(formatterDate(_pickDate)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    if (width < 600)
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                _selectedCategory = value;
                              }
                            });
                          }),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        // 取消掉 modal
                        // 將當前的頁面，將用於顯示 modal 的當前頁面移除，回到前一個頁面。
                        Navigator.pop(context);
                      },
                      child: const Text('CANCEL'),
                    ),
                    ElevatedButton(
                      onPressed: _onSubmit,
                      child: const Text('SAVE'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
