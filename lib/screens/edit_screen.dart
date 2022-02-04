import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocketify/models/expense_model.dart';
import 'package:pocketify/utils/routes.dart';
import 'package:pocketify/utils/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class EditScreen extends StatelessWidget {
  late ExpenseModel expense;
  EditScreen({Key? key, required this.expense}) : super(key: key);

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
        title: "Detail".text.color(Colors.white).size(18).make(),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.VIPSubscriptionScreen);
            },
            child: Image.asset(
              AppIcons.block_ads,
              color: Colors.white,
              height: 25,
              width: 25,
            ),
          ).pOnly(right: 15),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 25,
            ),
          ).pOnly(right: 15)
        ],
      ),
      body: Container(
        width: context.screenWidth,
        color: AppTheme.BASE_dullAccent,
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    tileColor: Colors.white,
                    leading: Image.asset(
                      expense.icon,
                      height: 30,
                      width: 30,
                    ),
                    title: "${expense.title}".text.size(13).make(),
                    trailing: "${expense.expense}".text.bold.size(17).make(),
                  ),
                  Divider(
                    color: Vx.gray400,
                    height: 2,
                  ).pSymmetric(h: 8),
                  ListTile(
                    tileColor: Colors.white,
                    leading: Icon(
                      Icons.category,
                      color: Colors.black,
                    ),
                    title: "Category".text.size(13).make(),
                    trailing: "${expense.category}".text.size(13).make(),
                  ),
                  Divider(
                    color: Vx.gray400,
                    height: 2,
                  ).pSymmetric(h: 8),
                  ListTile(
                    tileColor: Colors.white,
                    leading: Icon(
                      CupertinoIcons.calendar,
                      color: Colors.black,
                    ),
                    title: "Date".text.size(13).make(),
                    trailing:
                        "${DateFormat.yMd().add_jm().format(expense.date)}"
                            .text
                            .make(),
                  ),
                  Divider(
                    color: Vx.gray400,
                    height: 2,
                  ).pSymmetric(h: 8),
                  ListTile(
                    tileColor: Colors.white,
                    leading: Icon(
                      CupertinoIcons.rectangle_paperclip,
                      color: Colors.black,
                    ),
                    title: "Remark".text.size(13).make(),
                    trailing: InkWell(
                      splashColor: context.cardColor,
                      focusColor: context.cardColor,
                      child: Text(
                        expense.remark != null
                            ? expense.remark!.substring(0, 25) + "..."
                            : "",
                        style: TextStyle(fontSize: 10),
                      ),
                      onTap: () {
                        if (expense.remark != null &&
                            expense.remark!.trim() != "")
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: "Remark".text.size(15).bold.make(),
                                  content: Text(
                                    expense.remark != null
                                        ? expense.remark!
                                        : "",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(left: 22, top: 5),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: "OK"
                                            .text
                                            .bold
                                            .color(context.cardColor)
                                            .make())
                                  ],
                                  actionsPadding: EdgeInsets.all(5),
                                );
                              });
                      },
                    ),
                  ),
                ],
              ).p(6),
            ).p12(),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(context.cardColor),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      size: 20,
                    ).pOnly(right: 10),
                    "EDIT".text.make()
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.CalculatorScreen);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}