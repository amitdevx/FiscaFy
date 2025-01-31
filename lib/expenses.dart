import 'package:expense_tracker/calculation_screen.dart';
import 'package:expense_tracker/expenses_list.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/mod/expens.dart';
import 'package:expense_tracker/notification_screen.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<Expense> registeredExpenses = [];
  double totalAmount = 0;
  final _budgetController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _inputText = '0.0';
  double avlBlnc = 0.0;

  @override
  void dispose() {
    _budgetController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  //open URL
  Future<void> openLink(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    for (var expense in registeredExpenses) {
      totalAmount += expense.amount;
    }
  }

//function for showing dialog or alert for clear items
  void _resetAlert() {
    if (registeredExpenses.isEmpty &&
        totalAmount == 0 &&
        _inputText == '0.0' &&
        avlBlnc == 0) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('No items'),
              content: Text('There is nothing to clear.'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text('Okay')),
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Clear!'),
              content: Text(
                  'Are you sure want to clear all items and reset screen ?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _resetInputs();
                    },
                    child: Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text('No'))
              ],
            );
          });
    }
  }

//function to reset all inputs
  void _resetInputs() {
    setState(() {
      // Clear the list of expenses
      registeredExpenses.clear();

      // Reset the state variables
      totalAmount = 0;
      _inputText = '0.0';
      avlBlnc = 0;
    });
    // Show a SnackBar to notify the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Center(child: Text('All reset')),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

//function to show alert when user going to exceed budget
  void showBudgetAlert() {
    final budget = double.tryParse(_inputText) ?? 0.0;
    if (budget > 0 && totalAmount >= budget * 0.9) {
      // Show alert when totalAmount is >= 90% of the budget
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Alert!',
              style: TextStyle(color: Colors.red),
            ),
            content: Text.rich(TextSpan(children: [
              TextSpan(
                text: 'You are close to ',
              ),
              TextSpan(
                  text: 'exceeding your budget!',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 253, 120, 111))),
            ])),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('Save'),
              ),
            ],
          );
        },
      );
    }
  }

//function to show alert when budget in 0
  void showEnterBudgetAlert() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Alert!'),
          content: Text('Please enter budget first.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                _budget();
              },
              child: Text('Enter here'),
            ),
          ],
        );
      },
    );
  }

//platform spacific dialog box
  void _showDialog() {
    //showing dialog for IOS
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Budget is empty!'),
              content: Text('Please enter valid budget.'),
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
    //showing dialog for IOS
    else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Budget is empty!'),
              content: Text('Please enter valid budget.'),
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

  //function to calculate available balance
  void _calculateAvailableBlnc() {
    setState(() {
      avlBlnc = (double.tryParse(_inputText) ?? 0.0) - totalAmount;
    });
  }

//function to add budget
  _budget() {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 30, keyboardSpace),
                child: Column(
                  children: [
                    Text(
                      'Enter Budget',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _budgetController,
                      focusNode: _focusNode,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Type here...',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          prefixText: '\u20B9 ',
                          suffixIcon: IconButton(
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.transparent),
                              onPressed: () {
                                _budgetController.clear();
                              },
                              icon: Icon(
                                Icons.clear_rounded,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () {
                        final validBudget = _budgetController.text;
                        final parsedBudget = double.tryParse(validBudget);

                        final budgetIsInvalid = validBudget.isEmpty ||
                            parsedBudget == null ||
                            parsedBudget <= 0;
                        if (budgetIsInvalid) {
                          _showDialog();
                          return;
                        }
                        setState(() {
                          _inputText = _budgetController.text;
                          _calculateAvailableBlnc(); // Update avlBlnc
                        });
                        Navigator.of(context).pop();
                        setState(() {
                          _inputText = _budgetController.text;
                        });
                      },
                      child: Text('Enter'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

//function to open expense add page
  _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(
            onAddExpense: _addExpense,
          );
        });
  }

//function to add expense in the list and calculate total amount or spend
  void _addExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
      totalAmount += expense.amount;
      _calculateAvailableBlnc();
      showBudgetAlert();
    });
  }

//function to remove expense from the list
  void _removeExpense(Expense expense) {
    final expenseIndex = registeredExpenses.indexOf(expense);
    setState(() {
      registeredExpenses.remove(expense);
      totalAmount -= expense.amount;
      _calculateAvailableBlnc();
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: Text('Expense removed'),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      action: SnackBarAction(
          textColor: Theme.of(context).colorScheme.onSecondary,
          label: 'Undo',
          onPressed: () {
            setState(() {
              registeredExpenses.insert(expenseIndex, expense);
              totalAmount += expense.amount;
              _calculateAvailableBlnc();
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var witdh = MediaQuery.of(context).size.width;
    MediaQuery.of(context).orientation;
    Widget mainContent = Center(
      child: Lottie.asset(
        'assets/nd.json',
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      ),
    );
    if (registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: witdh < 600
          ? AppBar(
              backgroundColor: const Color.fromARGB(255, 0, 39, 103),
              foregroundColor: Colors.white,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FiscaFy',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Track your expenses',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ],
                ),
              ),
              actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: PopupMenuButton<String>(
                      elevation: 4,

                      icon: Icon(
                        Icons.more_vert,
                      ), // Vertical ellipsis icon
                      onSelected: (String result) {
                        // Handle the selection
                        switch (result) {
                          case 'Notification':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationScreen()),
                            );
                            break;
                          case 'Reset':
                            _resetAlert();
                            break;
                          case 'CoinQuick':
                            openLink('https://coinquick-amitdev.netlify.app');
                            break;
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.grey.shade300),
                      ).copyWith(
                        side: BorderSide.none,
                      ),
                      offset: Offset(0, 56),

                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem<String>(
                            value: 'Notification',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Notification'),
                                Icon(
                                  Icons.notifications,
                                  color: Color.fromARGB(255, 7, 164, 255),
                                )
                              ],
                            ),
                          ),
                          const PopupMenuDivider(),
                          const PopupMenuItem<String>(
                            value: 'Reset',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Clear all items'),
                                Icon(
                                  Icons.clear_rounded,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                          const PopupMenuDivider(),
                          const PopupMenuItem<String>(
                            value: 'CoinQuick',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('CoinQuck'),
                                Icon(
                                  Icons.currency_exchange_rounded,
                                  color: Color.fromARGB(255, 224, 191, 2),
                                )
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                  ),
                ])
          : AppBar(
              backgroundColor: const Color.fromARGB(255, 0, 39, 103),
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: false,
              surfaceTintColor: Colors.transparent,
              toolbarHeight: 55,
              title: Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FiscaFy',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Track your expenses',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: IconButton(
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    icon: Icon(
                      Icons.add_circle,
                      // color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      final budget = double.tryParse(_inputText) ?? 0.0;

                      if (budget <= 0) {
                        showEnterBudgetAlert(); // Show alert if the budget is empty or invalid
                      } else {
                        _openAddExpenseOverlay(); // Only open expense overlay if budget is valid
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                    ), // Vertical ellipsis icon
                    onSelected: (String result) {
                      // Handle the selection
                      switch (result) {
                        case 'Notification':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationScreen()),
                          );
                          break;
                        case 'Reset':
                          _resetAlert();
                          break;
                        case 'CoinQuick':
                          openLink('https://coinquick-amitdev.netlify.app');
                          break;
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey.shade300),
                    ).copyWith(
                      side: BorderSide.none,
                    ),
                    offset: Offset(-15, 56),
                    elevation: 4, //
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem<String>(
                          value: 'Notification',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Notification'),
                              Icon(Icons.notifications,
                                  color: Color.fromARGB(255, 7, 164, 255))
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem<String>(
                          value: 'Reset',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Clear all items'),
                              Icon(Icons.clear_rounded, color: Colors.red)
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem<String>(
                          value: 'CoinQuick',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('CoinQuck'),
                              Icon(
                                Icons.currency_exchange_rounded,
                                color: Color.fromARGB(255, 244, 216, 54),
                              )
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: witdh < 600
          ? BottomAppBar(
              shape: AutomaticNotchedShape(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(40, 20),
                topRight: Radius.elliptical(40, 20),
              ))),
              height: 60,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.only(top: 19), child: null),
              ),
            )
          : null,
      body: witdh < 600
          ? Column(
              children: [
                CalculationScreen(
                  avlBlnc: avlBlnc,
                  budget: _budget,
                  inputText: _inputText,
                  totalAmount: totalAmount,
                ),
                Expanded(child: mainContent)
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: CalculationScreen(
                    avlBlnc: avlBlnc,
                    budget: _budget,
                    inputText: _inputText,
                    totalAmount: totalAmount,
                  ),
                ),
                Expanded(child: mainContent),
              ],
            ),
      floatingActionButton: witdh < 600
          ? Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromARGB(255, 1, 42, 110)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    onPressed: () {
                      final budget = double.tryParse(_inputText) ?? 0.0;
                      if (budget <= 0) {
                        showEnterBudgetAlert(); // Show alert if the budget is empty or invalid
                      } else {
                        _openAddExpenseOverlay(); // Only open expense overlay if budget is valid
                      }
                    },
                    child: const Icon(
                      Icons.add_rounded,
                      size: 30,
                    ),
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
