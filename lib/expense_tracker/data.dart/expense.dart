import 'package:test/expense_tracker/models/expense.dart';

final List<Expense> registerExpenseList = [
  Expense(
    title: 'Dart Course',
    amount: 20.99,
    date: DateTime(2023, 12, 10),
    category: Category.work,
  ),
  Expense(
    title: 'Flutter Course',
    amount: 20.99,
    date: DateTime(2023, 12, 15),
    category: Category.work,
  ),
  Expense(
    title: 'KFC',
    amount: 10.99,
    date: DateTime.now(),
    category: Category.food,
  ),
  Expense(
    title: 'JAPAN',
    amount: 100.25,
    date: DateTime(2023, 10, 10),
    category: Category.travel,
  ),
  Expense(
    title: 'KTV',
    amount: 15.85,
    date: DateTime(2023, 11, 25),
    category: Category.leisure,
  ),
];
