import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocketify/models/expense_model.dart';
import 'package:velocity_x/velocity_x.dart';

class InitialiseExpensesList {
  static List<Widget> myExpenses = [];
  static double total = 0.0;

  static List<Widget> initialiseAndFetchExpenses(DateTime date) {
    //Adding expenses of particular date
    myExpenses = [];
    for (var expenseOfTheDate in ExpenseModel.expenseMap[date]!) {
      total += expenseOfTheDate.expense;
      myExpenses.add(GestureDetector(
        onTap: () {},
        child: ListTile(
          tileColor: Colors.white,
          leading: Image.asset(
            expenseOfTheDate.icon,
          ).w(32).h(32),
          title: Text(
            "${expenseOfTheDate.title}",
            style: TextStyle(fontSize: 12),
          ),
          trailing: Text(
            "${expenseOfTheDate.expense}",
            style: TextStyle(fontSize: 12),
          ),
        ).pSymmetric(v: 1),
      ));
    }
    //Adding header for the expense records
    myExpenses.insert(
      0,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("${DateFormat.yMMMMEEEEd().format(date)}"),
          Text("${total}")
        ],
      ).p8(),
    );
    total = 0;
    return myExpenses;
  }
}
