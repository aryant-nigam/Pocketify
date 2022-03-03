import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pocketify/utils/ExpenseNotifier.dart';
import 'package:pocketify/utils/themes.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class BudgetSettings extends StatefulWidget {
  const BudgetSettings({Key? key}) : super(key: key);

  @override
  State<BudgetSettings> createState() => _BudgetSettingsState();
}

class _BudgetSettingsState extends State<BudgetSettings> {
  late int _date = -1;
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseNotifier>(
        builder: (context, expenseNotifier, child) {
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
          title: "Settings".text.color(Colors.white).size(18).make(),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: context.screenWidth,
            height: context.screenHeight,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 250,
                  child: LottieBuilder.asset("assets/settings_anim.json"),
                ).pOnly(top: 10),
                Text(
                  "Here you can set your balance for a month so as to put a check on the money remaining with you.",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ).pOnly(left: 20, right: 20, top: 10),
                Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: context.cardColor,
                    ).pOnly(top: 20, right: 8),
                    Flexible(
                      child: TextField(
                        cursorColor: context.cardColor,
                        style: TextStyle(
                            color: Color.fromRGBO(96, 9, 100, 0.6),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: "Enter your planned amount for month",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(96, 9, 100, 0.6)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(96, 9, 100, 0.5))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: context.cardColor)),
                          label: Text(
                            "Amount",
                            style: TextStyle(
                                color: context.cardColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ).pSymmetric(h: 10),
                    )
                  ],
                ).pSymmetric(h: 15, v: 10),
                Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: context.cardColor,
                    ).pOnly(right: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Set Start Date",
                          style: TextStyle(
                              color: context.cardColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ).pSymmetric(h: 10),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (context, updateDialogState) {
                                      return AlertDialog(
                                        titlePadding: EdgeInsets.zero,
                                        title: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Set start date",
                                                style: TextStyle(fontSize: 18),
                                              ).pOnly(bottom: 5, top: 10),
                                              Divider(
                                                thickness: 1.5,
                                                color: Vx.gray300,
                                              )
                                            ],
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        content: ListView.builder(
                                            itemCount: DateUtils.getDaysInMonth(
                                                DateTime.now().year,
                                                DateTime.now().month),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      toggleable: true,
                                                      value: index + 1,
                                                      groupValue: _date,
                                                      activeColor:
                                                          context.cardColor,
                                                      onChanged: (int? value) {
                                                        updateDialogState(() {
                                                          _date = value!;
                                                        });
                                                        setState(() {
                                                          _date = value!;
                                                        });
                                                        print(_date);
                                                      },
                                                    ).pOnly(right: 10),
                                                    "${index + 1}"
                                                        .text
                                                        .size(15)
                                                        .fontWeight(
                                                            FontWeight.w500)
                                                        .make()
                                                  ],
                                                ),
                                              );
                                            }).p0(),
                                        actionsPadding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, true);
                                              },
                                              child: "OK"
                                                  .text
                                                  .color(context.cardColor)
                                                  .size(15)
                                                  .bold
                                                  .make())
                                        ],
                                      );
                                    },
                                  );
                                });
                          },
                          child: Text(
                            _date == -1
                                ? DateFormat("dd-MM-yyyy")
                                    .format(DateTime.now())
                                : DateFormat("dd-MM-yyyy").format(DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        _date)) +
                                    " - " +
                                    DateFormat("dd-MM-YYYY").format(DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            _date)
                                        .add(Duration(days: 30))),
                            style: TextStyle(
                                color: Color.fromRGBO(96, 9, 100, 0.6),
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ).pOnly(left: 10, right: 10, top: 5),
                        ),
                      ],
                    )
                  ],
                ).pSymmetric(h: 15, v: 10),
              ],
            ),
          ),
        ),
      );
    });
  }
}