import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/expense_model.dart';

class ExpenseVisualizationScreen extends StatefulWidget {
  const ExpenseVisualizationScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseVisualizationScreen> createState() =>
      _ExpenseVisualizationScreenState();
}

class _ExpenseVisualizationScreenState
    extends State<ExpenseVisualizationScreen> {
  late List<ExpenseModel> expensesList = [];
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
  @override
  void initState() {
    for (DateTime date in ExpenseModel.dateList) {
      expensesList.addAll(ExpenseModel.expenseMap[date]!);
    }
    print("Aryant : ${expensesList.length}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            CupertinoIcons.back,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: "Visualize".text.color(Colors.white).size(18).make(),
      ),
      body: Container(
        color: Colors.white,
        height: context.screenHeight,
        width: context.screenWidth,
        child: Column(
          children: [
            Container(
              width: context.screenWidth,
              height: 250,
              child: SfCircularChart(
                title: ChartTitle(
                    text: "Your Expenses",
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: context.cardColor,
                        fontFamily: GoogleFonts.poppins().fontFamily)),
                legend: Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.scroll,
                ),
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                  PieSeries<ExpenseModel, String>(
                      dataSource: expensesList,
                      xValueMapper: (ExpenseModel expense, _) =>
                          "${DateFormat("dd-MM-yyyy").format(expense.date)}",
                      yValueMapper: (ExpenseModel expense, _) =>
                          expense.expense,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      enableTooltip: true)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
