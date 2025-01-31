// this third party package is used to generate unique id for each expense
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// this variable is used to create object of uuid for generate unique id for each expense
const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  movie,
  work,
  shopping,
  bills,
  sports,
  health,
  transport,
  housing,
  utilities,
}

const categoryIcon = {
  Category.food: Icons.fastfood_outlined,
  Category.travel: Icons.flight,
  Category.movie: Icons.movie,
  Category.work: Icons.work,
  Category.shopping: Icons.shopping_cart,
  Category.bills: Icons.receipt,
  Category.sports: Icons.sports_esports,
  Category.health: Icons.local_hospital,
  Category.transport: Icons.directions_bus,
  Category.housing: Icons.home,
  Category.utilities: Icons.miscellaneous_services_sharp,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  String get formattedDate {
    return formatter.format(date);
  }
}
