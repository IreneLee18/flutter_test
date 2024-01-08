import 'package:flutter/material.dart';
import 'package:test/expense_tracker/data.dart/expense.dart';
import 'package:test/expense_tracker/models/expense.dart';
import 'package:test/expense_tracker/widget/chart/chart_bar.dart';
import 'package:test/expense_tracker/widget/expense_list/expense_list.dart';
import 'package:test/expense_tracker/widget/new_expense/new_expense.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpenseTrackerState();
  }
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  final List<Expense> _expenseList = [...registerExpenseList];

  void _onOpen() {
    showModalBottomSheet(
      // 讓我們可以避開一些影響我們UI的功能（如鏡頭）
      useSafeArea: true,
      // 讓 modal 撐滿整個畫面
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onSave: _addExpense),
    );
  }

  void _addExpense(Expense expanse) {
    setState(() {
      _expenseList.add(expanse);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expenseList.indexOf(expense);
    setState(() {
      _expenseList.remove(expense);
    });
    // 當快速刪除多筆，依舊只會顯示第一筆刪除的資料，直到時間過了才會顯示下一個
    // 因此需要加上 ScaffoldMessenger.of(context).clearSnackBars(); 來刪除前一個 snackbar
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 10), // 設定顯示時長
        content: Text('Delete Expense: ${expense.title}'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expenseList.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent;
    mainContent = _expenseList.isEmpty
        ? const Center(
            child: Text(
              'No Expense ~~\nPlease create some Expense !',
              textAlign: TextAlign.center,
            ),
          )
        : ExpenseList(
            expenseList: _expenseList,
            onDelete: _removeExpense,
          );

    return (Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _onOpen,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      // 如果有 Column + ListView 的組合會遇到問題
      // Flutter 會不知道如何調整大小或限制內部列表要呈現怎麼樣子
      // 因此需要加上 Expanded 來防止這問題發生
      body: width < 600
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chart(expenses: _expenseList),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _expenseList)),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    ));
  }
}
