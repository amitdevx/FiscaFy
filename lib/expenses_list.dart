import 'package:expense_tracker/mod/expens.dart';
import 'package:expense_tracker/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        // shrinkWrap: true,
        itemCount: expenses.length,
        itemBuilder: (ctx, idx) {
          return Card(
            elevation: 2,
            shadowColor: Colors.black38,
            clipBehavior: Clip.antiAlias,
            child: Dismissible(
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  // padding: EdgeInsets.only(right: 20),
                  // margin: EdgeInsets.symmetric(
                  //     horizontal: Theme.of(context).cardTheme.margin!.horizontal),
                  child: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                onDismissed: (direction) {
                  onRemoveExpense(expenses[idx]);
                },
                key: ValueKey(expenses[idx]),
                child: ExpenseItem(
                  expenses: expenses[idx],
                  onRemoveExpense: onRemoveExpense,
                )),
          );
        });
  }
}
