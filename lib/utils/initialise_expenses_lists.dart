import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:intl/intl.dart';
import 'package:pocketify/models/expense_model.dart';
import 'package:pocketify/utils/routes.dart';
import 'package:pocketify/utils/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class InitialiseExpensesList {
  static List<Widget> myExpenses = [];
  static double total = 0.0;
  static int count = 0;

  static List<Widget> initialiseAndFetchExpenses(
      DateTime date, BuildContext context) {
    //Adding expenses of particular date
    myExpenses = [];
    for (var expenseOfTheDate in ExpenseModel.expenseMap[date]!) {
      total += expenseOfTheDate.expense;
      myExpenses.add(GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.EditScreen);
        },
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
      Container(
        color: Vx.gray100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${DateFormat.yMMMMEEEEd().format(date)}",
              style: TextStyle(fontSize: 10),
            ),
            Text("Expense: ${total}", style: TextStyle(fontSize: 10))
          ],
        ).p4(),
      ),
    );
    total = 0;
    count++;
    return myExpenses;
  }
}
