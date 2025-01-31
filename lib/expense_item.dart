import 'package:expense_tracker/mod/expens.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatefulWidget {
  const ExpenseItem(
      {required this.expenses, required this.onRemoveExpense, super.key});
  final Expense expenses;

  final void Function(Expense expense) onRemoveExpense;

  @override
  State<ExpenseItem> createState() => _ExpenseItemState();
}

class _ExpenseItemState extends State<ExpenseItem> {
  _showEditDelete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an Action'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  widget.onRemoveExpense(widget.expenses);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.expenses.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                onPressed: _showEditDelete,
                icon: Icon(Icons.more_vert),
                style: IconButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Theme.of(context).iconTheme.color),
              )
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text(
                '\u20B9 ${widget.expenses.amount.toString()}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(categoryIcon[widget.expenses.category]),
                  SizedBox(
                    width: 9,
                  ),
                  Text(widget.expenses.formattedDate)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
