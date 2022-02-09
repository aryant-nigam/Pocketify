import 'package:flutter/cupertino.dart';

import '../models/expense_model.dart';

class ExpenseNotifier extends ChangeNotifier {
  List<ExpenseModel> expenseList = []; //= ExpenseModel.expenseList;
  List<String> dateList = []; //ExpenseModel.dateList;

  initList() {
    dateList = ExpenseModel.dateList;
    expenseList = ExpenseModel.expenseList;
    //notifyListeners();
  }

  void addExpenses(ExpenseModel expense) {
    if (!dateList.contains(myDateFormatter(expense.date)))
      dateList.add(myDateFormatter(expense.date));

    expenseList.add(expense);
    notifyListeners();
  }

  void deleteExpenses(ExpenseModel expense) {
    expenseList.removeWhere((item) => item.id == expense.id);
    notifyListeners();
  }

  void updateExpenses(ExpenseModel expense) {
    deleteExpenses(expense);
    addExpenses(expense);
    notifyListeners();
  }

  List<ExpenseModel> Filter(String formattedDate) {
    List<ExpenseModel> listOfDate = [];
    ExpenseModel.expenseList.forEach((expense) {
      if (myDateFormatter(expense.date) == formattedDate)
        listOfDate.add(expense);
    });
    return listOfDate;
  }

  ExpenseModel? getObjectWith2(int id) {
    for (var expense in expenseList) if (expense.id == id) return expense;
  }

  static ExpenseModel? getObjectWith(int id) {}
}
