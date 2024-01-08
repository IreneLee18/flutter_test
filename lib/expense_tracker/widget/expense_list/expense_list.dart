import 'package:flutter/material.dart';
import 'package:test/expense_tracker/models/expense.dart';
import 'package:test/expense_tracker/widget/expense_list/expense_list_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {required this.expenseList, required this.onDelete, super.key});
  final List<Expense> expenseList;
  final void Function(Expense expense) onDelete;

  @override
  Widget build(BuildContext context) {
    // 這裡不推薦使用 column，因為不確定使用者會增加多少個 list
    // 因此推薦使用 listView
    // listView 是一個可以滾動的列表
    // ＊不推薦使用：
    //   ListView(children: []);
    //   他會一次創建所有的子元素，即使他在畫面上是不可見的，這樣會影響效能
    // ＊推薦使用：
    //   ListView.builder(itemBuilder: itemBuilder);
    //   當滾動到可視圖內才會創建，因此可以減少效能

    return ListView.builder(
      // 呈現總共有多少個列表
      itemCount: expenseList.length,
      // Dismissible：可以使ListItem滑走的方式刪除
      itemBuilder: (ctx, i) => Dismissible(
        // 當要刪除東西一定要傳入 key，讓 flutter 確保不會刪錯東西
        key: ValueKey(expenseList[i]),
        onDismissed: (direction) {
          onDelete(expenseList[i]);
        },
        // 這邊是限制我只能往右滑，我不能往左滑
        // 右滑：startToEnd
        // 左滑：endToStart
        direction: DismissDirection.endToStart,
        // 設定滑動後 ListItem 的背景
        background: Container(
          // color: Colors.red[400],
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
        child: ExpenseItem(expenseList[i]),
      ),
    );
  }
}
