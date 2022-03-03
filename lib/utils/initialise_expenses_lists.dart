import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:intl/intl.dart';
import 'package:pocketify/models/expense_model.dart';
import 'package:pocketify/screens/calculator_screen.dart';
import 'package:pocketify/screens/edit_screen.dart';
import 'package:pocketify/utils/ExpenseNotifier.dart';
import 'package:pocketify/utils/routes.dart';
import 'package:pocketify/utils/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class InitialiseExpensesList {
  List<ExpenseModel> expenseList = [];
  List<Widget> myExpensesTiles = [];
  double totalExpense = 0.0;
  double totalIncome = 0.0;
  int count = 0;
  InitialiseExpensesList({required this.expenseList});

  List<Widget> initialiseAndFetchExpenses(BuildContext context) {
    for (var expenseOfTheDate in expenseList) {
      if (expenseOfTheDate.category == "Income")
        totalIncome += expenseOfTheDate.expense;
      else
        totalExpense += expenseOfTheDate.expense;

      myExpensesTiles.add(GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditScreen(id: expenseOfTheDate.id)));
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
    myExpensesTiles.insert(
      0,
      Container(
        color: Vx.gray100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Date : ${myDateFormatter(expenseList[0].date)}",
              style: TextStyle(fontSize: 10),
            ), //myDateFormatter(expenseList[0].date)
            Row(
              children: [
                Visibility(
                        visible: totalExpense == 0.0 ? true : true,
                        child: Text("Expense: ${totalExpense}",
                            style: TextStyle(fontSize: 10)))
                    .pOnly(right: 10),
                Visibility(
                    visible: totalIncome == 0.0 ? true : true,
                    child: Text("Income: ${totalIncome}",
                        style:
                            TextStyle(fontSize: 10, color: context.cardColor)))
              ],
            )
          ],
        ).p4(),
      ),
    );

    totalExpense = 0;
    totalIncome = 0;
    count++;
    return myExpensesTiles;
  }
}
