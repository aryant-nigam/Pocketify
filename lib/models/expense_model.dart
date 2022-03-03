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

  static List<ExpenseModel> expenseList = [
    ExpenseModel(
        id: 1,
        title: "Food",
        icon: AppIcons.food,
        expense: 500,
        date: DateTime(2022, 1, 30),
        category: "Income",
        remark: "At Ajay Rai's clinic"),
    ExpenseModel(
        id: 2,
        title: "Entertainment",
        icon: AppIcons.entertainment,
        expense: -500,
        date: DateTime(2022, 1, 30),
        category: "Expenses"),
    ExpenseModel(
        id: 3,
        title: "Health",
        icon: AppIcons.health,
        expense: -500,
        date: DateTime(2022, 1, 30),
        category: "Expenses"),
    ExpenseModel(
        id: 4,
        title: "Food",
        icon: AppIcons.food,
        expense: -500,
        date: DateTime(2022, 1, 31),
        category: "Expenses"),
    ExpenseModel(
        id: 5,
        title: "Entertainment",
        icon: AppIcons.entertainment,
        expense: -500,
        date: DateTime(2022, 1, 31),
        category: "Expenses"),
    ExpenseModel(
        id: 6,
        title: "Health",
        icon: AppIcons.health,
        expense: -500,
        date: DateTime(2022, 1, 31),
        category: "Expenses"),
    ExpenseModel(
        id: 7,
        title: "Health",
        icon: AppIcons.health,
        expense: 500,
        date: DateTime(2022, 2, 1),
        category: "Income"),
    ExpenseModel(
        id: 8,
        title: "Health",
        icon: AppIcons.health,
        expense: 500,
        date: DateTime(2022, 2, 1),
        category: "Income"),
    ExpenseModel(
        id: 9,
        title: "Health",
        icon: AppIcons.health,
        expense: 500,
        date: DateTime(2022, 2, 1),
        category: "Income"),
    ExpenseModel(
        id: 10,
        title: "Health",
        icon: AppIcons.health,
        expense: -500,
        date: DateTime(2022, 2, 2),
        category: "Expenses"),
    ExpenseModel(
        id: 11,
        title: "Health",
        icon: AppIcons.health,
        expense: 500,
        date: DateTime(2022, 2, 2),
        category: "Income"),
    ExpenseModel(
        id: 12,
        title: "Health",
        icon: AppIcons.health,
        expense: 500,
        date: DateTime(2022, 2, 2),
        category: "Income"),
  ];

  static List<String> dateList = [
    "Jan 30, 2022",
    "Jan 31, 2022",
    "Feb 1, 2022",
    "Feb 2, 2022"
  ];

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
        expense: map["expenseExpense"],
        date: DateTime.parse(map["expenseDate"]),
        category: map["expenseCategory"],
        remark: map["expenseRemark"]);
  }
}
