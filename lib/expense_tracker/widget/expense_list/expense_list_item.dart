import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.purple[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              // 套用 ThemeData 設定的 theme
              style: Theme.of(context).textTheme.titleLarge,
              // style: GoogleFonts.montserrat(
              //   fontWeight: FontWeight.bold,
              //   fontSize: 16,
              // ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                // Space 佔用所有剩餘的空間，因此會將上方推到最左，下方推到最右
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcon[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
