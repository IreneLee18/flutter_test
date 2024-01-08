import 'package:flutter/material.dart';
import 'package:test/expense_tracker/models/expense.dart';
import 'package:test/expense_tracker/widget/chart/chart.dart';

class Chart extends StatefulWidget {
  const Chart({required this.expenses, super.key});
  final List<Expense> expenses;

  List<ExpenseBucket> get expenseChartData {
    return [
      ExpenseBucket.category(expenses, Category.food),
      ExpenseBucket.category(expenses, Category.travel),
      ExpenseBucket.category(expenses, Category.work),
      ExpenseBucket.category(expenses, Category.leisure),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (var data in expenseChartData) {
      if (data.expenseTotal > maxTotalExpense) {
        maxTotalExpense = data.expenseTotal;
      }
    }

    return maxTotalExpense;
  }

  @override
  State<StatefulWidget> createState() {
    return _ChartState();
  }
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    final isDarkModal =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return (Container(
      height: 180,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...widget.expenseChartData.map(
                  (item) => ChartBar(
                      fill: item.expenseTotal / widget.maxTotalExpense),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ...widget.expenseChartData.map(
                (item) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      categoryIcon[item.category],
                      color: isDarkModal
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
