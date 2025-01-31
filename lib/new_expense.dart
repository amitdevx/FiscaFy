import 'dart:io';

import 'package:expense_tracker/mod/expens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onAddExpense,
  });
  final void Function(Expense expense) onAddExpense;

  // final VoidCallback calSpend;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // first method to handel the user input
  // var _enerdedTitle = '';
  // void _saveTitle(String inpValue) {
  //   _enerdedTitle = inpValue;
  // }

  // second and convinent method to handel the user input
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _titleFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _titleFocusNode.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Invalid Input'),
              content: Text('Please enter valid title, amount and date'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text('Okay'))
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Invalid Input'),
              content: Text('Please enter valid title, amount and date'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text('Okay'))
              ],
            );
          });
    }
  }

  void _submitExpenseData() {
    final enteredTitle = _titleController.text.trim().isEmpty;
    final enteredAmount = _amountController.text;
    final amountIsInvalid =
        enteredAmount.isEmpty || double.tryParse(enteredAmount) == null;
    if (enteredTitle || amountIsInvalid || _selectedDate == null) {
      _showDialog();
      return;
    } else {
      Navigator.pop(context);
    }
    widget.onAddExpense(Expense(
        title: _titleController.text.trim(),
        amount: double.parse(_amountController.text),
        date: _selectedDate!,
        category: _selectedCategory));
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.day, now.month, now.year - 1);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  calculate() {}

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 25, 16, keyboardSpace + 16),
            child: Column(
              children: [
                //making it resposive for landscape if width greater that 600 pixle
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          focusNode: _titleFocusNode,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            suffixIcon: IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.transparent,
                              ),
                              onPressed: () {
                                _titleController.clear();
                              },
                              icon: Icon(
                                Icons.clear_rounded,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          focusNode: _amountFocusNode,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\u20B9 ',
                            labelText: 'Amount',
                            suffixIcon: IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.transparent,
                              ),
                              onPressed: () {
                                _amountController.clear();
                              },
                              icon: Icon(
                                Icons.clear_rounded,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    focusNode: _titleFocusNode,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    maxLength: 50,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      suffixIcon: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: () {
                          _titleController.clear();
                        },
                        icon: Icon(
                          Icons.clear_rounded,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 15),
                if (width >= 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                        iconSize: 20,
                        underline: Container(height: 0),
                        icon: Icon(
                          Icons.expand_circle_down_sharp,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                        elevation: 1,
                        borderRadius: BorderRadius.circular(5),
                        menuWidth: 120,
                        value: _selectedCategory,
                        items: Category.values.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val == null) return;
                          setState(() {
                            _selectedCategory = val;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!),
                          ),
                          IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                            onPressed: _presentDatePicker,
                            icon: Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          focusNode: _amountFocusNode,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\u20B9 ',
                            labelText: 'Amount',
                            suffixIcon: IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.transparent,
                              ),
                              onPressed: () {
                                _amountController.clear();
                              },
                              icon: Icon(
                                Icons.clear_rounded,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!),
                          ),
                          IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                            onPressed: _presentDatePicker,
                            icon: Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    ],
                  ),
                SizedBox(height: 15),
                if (width >= 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: _submitExpenseData,
                            child: Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                        iconSize: 20,
                        underline: Container(height: 0),
                        icon: Icon(
                          Icons.expand_circle_down_sharp,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                        elevation: 1,
                        borderRadius: BorderRadius.circular(5),
                        menuWidth: 120,
                        value: _selectedCategory,
                        items: Category.values.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val == null) return;
                          setState(() {
                            _selectedCategory = val;
                          });
                        },
                      ),
                      Spacer(),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _submitExpenseData();
                            },
                            child: Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
