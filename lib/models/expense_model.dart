import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../utils/app_icons.dart';

String myDateFormatter(DateTime date) {
  return DateFormat.yMMMd().format(date);
}

class ExpenseModel {
  int id;
  String title;
  String icon;
  double expense;
  DateTime date;
  String category;
  String? remark;

  ExpenseModel(
      {required this.id,
      required this.title,
      required this.icon,
      required this.expense,
      required this.date,
      required this.category,
      this.remark});

  static List<String> ExpenseCategoryList = [
    "Baby",
    "Beauty",
    "Bills",
    "Book",
    "Car",
    "Clothing",
    "Education",
    "Electronics",
    "Entertainment",
    "Food",
    "Fruits",
    "Gift",
    "Health",
    "Home",
    "Maintenance",
    "Office",
    "Others",
    "Pets",
    "Shopping",
    "Snacks",
    "Social",
    "Sports",
    "Tax",
    "Telephone",
    "Transportation",
    "Travel",
    "Vegetables",
    "Wine",
  ];

  static ExpenseModel getDefaultExpenseModel() {
    DateTime date = DateTime.now();
    return ExpenseModel(
        id: -1,
        title: "Food",
        icon: AppIcons.food,
        expense: 0,
        date: DateTime(date.year, date.month, date.day, TimeOfDay.now().hour,
            TimeOfDay.now().minute),
        category: "Expense");
  }

  Map<String, Object?> toMap() {
    return {
      "expenseId": this.id,
      "expenseTitle": this.title,
      "expenseIcon": this.icon,
      "expenseExpense": this.expense,
      "expenseDate": this.date.toString(),
      "expenseCategory": this.category,
      "expenseRemark": this.remark
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
        id: map["expenseId"],
        title: map["expenseTitle"],
        icon: map["expenseIcon"],
        expense: map["expenseExpense"].toDouble(),
        date: DateTime.parse(map["expenseDate"]),
        category: map["expenseCategory"],
        remark: map["expenseRemark"]);
  }
}
