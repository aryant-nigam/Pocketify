import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../utils/app_icons.dart';

String myDateFormatter(DateTime date) {
  return DateFormat.yMMMd().format(date);
}

class ExpenseModel with ChangeNotifier {
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
        category: "Expenses",
        remark: "At Ajay Rai's clinic"),
    ExpenseModel(
        id: 2,
        title: "Entertainment",
        icon: AppIcons.entertainment,
        expense: 500,
        date: DateTime(2022, 1, 30),
        category: "Expenses"),
    ExpenseModel(
        id: 3,
        title: "Health",
        icon: AppIcons.health,
        expense: 500,
        date: DateTime(2022, 1, 30),
        category: "Expenses"),
    ExpenseModel(
        id: 1,
        title: "Food",
        icon: AppIcons.food,
        expense: 500,
        date: DateTime(2022, 1, 31),
        category: "Expenses"),
    ExpenseModel(
        id: 2,
        title: "Entertainment",
        icon: AppIcons.entertainment,
        expense: 500,
        date: DateTime(2022, 1, 31),
        category: "Expenses"),
    ExpenseModel(
        id: 3,
        title: "Health",
        icon: AppIcons.health,
        expense: 500,
        date: DateTime(2022, 1, 31),
        category: "Expenses"),
    ExpenseModel(
        id: 3,
        title: "Health",
        icon: AppIcons.health,
        expense: 500,
        date: DateTime(2022, 2, 1),
        category: "Expenses"),
    ExpenseModel(
        id: 3,
        title: "Health",
        icon: AppIcons.health,
        expense: 500,
        date: DateTime(2022, 2, 1),
        category: "Expenses"),
    ExpenseModel(
        id: 3,
        title: "Health",
        icon: AppIcons.health,
        expense: 500,
        date: DateTime(2022, 2, 1),
        category: "Expenses"),
    ExpenseModel(
        id: 3,
        title: "Health",
        icon: AppIcons.health,
        expense: 500,
        date: DateTime(2022, 2, 2),
        category: "Expenses"),
    ExpenseModel(
        id: 3,
        title: "Health",
        icon: AppIcons.health,
        expense: 500,
        date: DateTime(2022, 2, 2),
        category: "Expenses"),
    ExpenseModel(
        id: 3,
        title: "Health",
        icon: AppIcons.health,
        expense: 500,
        date: DateTime(2022, 2, 2),
        category: "Expenses"),
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

  /*@override
  bool operator ==(Object other) {
    if (other is ExpenseModel &&
        this.id == other.id &&
        this.icon == other.icon &&
        this.expense == other.expense &&
        this.remark == other.remark &&
        this.date == other.date &&
        this.category == other.category &&
        this.title == other.title)
      return true;
    else
      return false;
  }

  static List<String> IncomeCategoryList = [];

  static void addToExpenses(ExpenseModel expenseModel) {
    if (expenseMap[myDateFormatter(expenseModel.date)] != null)
      expenseMap[myDateFormatter(expenseModel.date)]!.add(expenseModel);
    else {
      expenseMap.addAll({
        myDateFormatter(expenseModel.date): [expenseModel]
      });
    }
  }

  /*void removeFromExpenses(int id) {
    for (int i = 0; i < expenseMap[dateList[i]]!.length; i++)
      for (int j = 0; j < expenseMap[dateList[i]]!.length; j++) {
        if (expenseMap[dateList[i]]![j].id == id)
          expenseMap[dateList[i]]!.removeAt(j);
        if (expenseMap[dateList[i]]!.isEmpty) dateList.removeAt(i);
      }
  }*/

  static void updateExpense(ExpenseModel newExpense, ExpenseModel oldExpense) {
    if (myDateFormatter(newExpense.date) != myDateFormatter(oldExpense.date))
      findAndUpdate(expenseMap[myDateFormatter(newExpense.date)], newExpense);
    else
      findAndReplace(
          expenseMap[myDateFormatter(newExpense.date)], newExpense, oldExpense);
  }

  static void findAndUpdate(
      List<ExpenseModel>? expenseListOfDate, ExpenseModel newExpense) {
    if (expenseListOfDate == null) {
      expenseMap.addAll({
        myDateFormatter(newExpense.date): [newExpense]
      });
    } else if (expenseListOfDate.length == 0) {
      expenseMap[myDateFormatter(newExpense.date)]!.add(newExpense);
    } else {
      for (int i = 0; i < expenseListOfDate.length; i++)
        if (expenseListOfDate[i] == newExpense)
          expenseMap[myDateFormatter(newExpense.date)]![i] = newExpense;
    }
  }

  static void findAndReplace(List<ExpenseModel>? expenseListOfDate,
      ExpenseModel newExpense, ExpenseModel oldExpense) {
    addToExpenses(newExpense);
    removeExpense(oldExpense);
  }

  static void removeExpense(ExpenseModel oldExpense) {
    for (int i = 0;
        i < expenseMap[myDateFormatter(oldExpense.date)]!.length;
        i++)
      if (expenseMap[myDateFormatter(oldExpense.date)]![i] == oldExpense)
        expenseMap[myDateFormatter(oldExpense.date)]!.removeAt(i);
  }*/
}
