import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

// 製作唯一值
const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  leisure,
  work,
}

const categoryIcon = {
  Category.food: Icons.restaurant,
  Category.work: Icons.computer,
  Category.travel: Icons.airplanemode_active,
  Category.leisure: Icons.movie_creation_outlined,
};

class Expense {
  // 每當建立一個新的實例時，就自動賦予唯一值
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // 未使用套件：
  // String get formattedDate =>
  //     '${date.year}/${date.month < 10 ? '0${date.month}' : date.month}/${date.month < 10 ? '0${date.month}' : date.month}';

  // 老師範例套件：
  // String get formattedDate => formatter.format(date);

  // 自己找的套件：
  String get formattedDate => formatDate(date, [yyyy, '/', mm, '/', dd]);
}

class ExpenseBucket {
  const ExpenseBucket({required this.expenses, required this.category});
  ExpenseBucket.category(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final List<Expense> expenses;
  final Category category;

  double get expenseTotal {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
