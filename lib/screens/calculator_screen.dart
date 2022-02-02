import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:pocketify/models/expense_model.dart';
import 'package:pocketify/utils/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class CalculatorScreen extends StatefulWidget {
  CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  ScrollController controller = ScrollController();
  double _initialSheetChildSize = 0.07;
  double _dragScrollSheetExtent = 0;

  double _widgetHeight = 0;
  double _fabPosition = 0;
  double _fabPositionPadding = 20;
  double _markerPadding = 260;
  double _reductionRatio = 0;

  String _equation = "";
  int _equationLength = 0;
  bool _isEditing = false;
  late BuildContext draggableSheetContext;
  String cost = "0";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _fabPosition = _initialSheetChildSize * context.screenHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: context.cardColor,
      ),
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        color: AppTheme.BASE_dullAccent,
        child: Stack(
          children: [
            Container(
              width: context.screenWidth,
              height: 60,
              color: context.cardColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppIcons.food,
                    height: 35,
                    width: 35,
                  ).pOnly(left: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text("$cost",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22)),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text("${_equation}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12))
                              .pOnly(right: 6),
                          "="
                              .text
                              .size(12)
                              .fontWeight(FontWeight.w400)
                              .color(Colors.white)
                              .make()
                        ],
                      ).pOnly(right: 6),
                    ],
                  ),
                ],
              ).p2(),
            ),
            Positioned(
              width: context.screenWidth,
              left: 0,
              top: 70,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      tileColor: Colors.white,
                      leading: Icon(CupertinoIcons.calendar),
                      title: "Date  30 Jan 2022".text.size(13).make(),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ),
                    Divider(
                      height: 2,
                    ),
                    ListTile(
                      tileColor: Colors.white,
                      leading: Icon(
                        CupertinoIcons.clock_solid,
                      ),
                      title: "Time  20:24".text.size(13).make(),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ),
                    Divider(
                      height: 2,
                    ),
                    ListTile(
                      tileColor: Colors.white,
                      leading: Icon(Icons.edit),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          "Remark".text.size(13).make(),
                          10.widthBox,
                          /*TextField(
                            decoration: InputDecoration(
                              hintText: "Write a note",
                              /*border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,*/
                            ),
                            style: TextStyle(
                              color: Vx.gray400,
                              fontSize: 13,
                            ),
                          )*/ //hastobe an edit text
                        ],
                      ),
                    ),
                  ],
                ).p4(),
              ).p8(),
            ),
            NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                _widgetHeight = context.screenHeight;
                _dragScrollSheetExtent = notification.extent;
                _reductionRatio =
                    (notification.extent - notification.minExtent) /
                        (notification.maxExtent - notification.minExtent);
                // Calculate FAB position based on parent widget height and DraggableScrollable position
                _fabPosition = _dragScrollSheetExtent * _widgetHeight;

                setState(() {});
                return true;
              },
              child: DraggableScrollableSheet(
                minChildSize: 0.07,
                initialChildSize: 0.07,
                maxChildSize: 0.425,
                builder: (context, scrollController) {
                  return Material(
                    color: Colors.white,
                    elevation: 8,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: 1,
                      itemBuilder: (context, index) => Stack(
                        children: [
                          Calculator(
                            addInEquation: (String eqn) {
                              if (_equationLength < 10) {
                                _equation += eqn;
                                _isEditing = true;
                                _equationLength++;
                                setState(() {});
                              }
                            },
                            deleteInEquation: () {
                              _equationLength--;
                              _equation =
                                  _equation.substring(0, _equation.length - 1);
                              _isEditing = true;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ).p0(),
                  ).h(310);

                  //return SizedBox();
                },
              ),
            ),
            Positioned(
              right: 10,
              bottom: _fabPosition - (30 + (30 * _reductionRatio)),
              child: FloatingActionButton(
                backgroundColor: context.cardColor,
                onPressed: () {
                  _isEditing = false;
                  Parser parser = Parser();
                  _equation = _equation.replaceAll('÷', '/');
                  _equation = _equation.replaceAll('x', '*');

                  Expression exp = parser.parse(_equation);
                  double result =
                      exp.evaluate(EvaluationType.REAL, ContextModel());
                  cost = result.toStringAsFixed(2);
                  _equation = _equation.replaceAll('/', '÷');
                  _equation = _equation.replaceAll('*', 'x');
                  setState(() {});
                },
                child: _isEditing
                    ? Icon(
                        Icons.done,
                        size: 32,
                      )
                    : "123".text.xl.make(),
              ),
            ),
            Positioned(
                right: context.screenWidth / 2 - 12.5,
                bottom: _fabPosition - (30 + (30 * _reductionRatio)),
                child: Container(
                  decoration: BoxDecoration(
                      color: context.cardColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: 5,
                  width: 25,
                )),
          ],
        ),
      ),
    );
  }
}

class Calculator extends StatelessWidget {
  final Function(String s) addInEquation;
  final void Function() deleteInEquation;
  const Calculator(
      {Key? key, required this.addInEquation, required this.deleteInEquation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: context.screenWidth,
      height: 306,
      child: Column(
        children: [
          Container(
            height: 20,
            child: Align(
              child: 30.widthBox.backgroundColor(context.cardColor),
              alignment: Alignment.center,
            ),
          ),
          Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation("8");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      "8",
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ).centered(),
                  ).pOnly(left: 8),
                ),
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation("7");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      "7",
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ).centered(),
                  ).pOnly(left: 8),
                ),
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation("9");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      "9",
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ).centered(),
                  ).pOnly(left: 8),
                ),
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation("÷");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(context.cardColor)),
                    child: Text(
                      "÷",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ).centered(),
                  ).pOnly(left: 8, right: 8),
                ),
              ],
            ),
          ).pOnly(bottom: 8),
          Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation("4");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      "4",
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ).centered(),
                  ).pOnly(left: 8),
                ),
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation("5");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ).centered(),
                  ).pOnly(left: 8),
                ),
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation("6");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      "6",
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ).centered(),
                  ).pOnly(left: 8),
                ),
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation("x");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(context.cardColor)),
                    child: Text(
                      "x",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ).centered(),
                  ).pOnly(left: 8, right: 8),
                ),
              ],
            ),
          ).pOnly(bottom: 8),
          Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation("1");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ).centered(),
                  ).pOnly(left: 8),
                ),
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation("2");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      "2",
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ).centered(),
                  ).pOnly(left: 8),
                ),
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation("3");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      "3",
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ).centered(),
                  ).pOnly(left: 8),
                ),
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation("-");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(context.cardColor)),
                    child: Text(
                      "-",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ).centered(),
                  ).pOnly(left: 8, right: 8),
                ),
              ],
            ),
          ).pOnly(bottom: 8),
          Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation("0");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ).centered(),
                  ).pOnly(left: 8),
                ),
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation(".");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      ".",
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ).centered(),
                  ).pOnly(left: 8),
                ),
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      deleteInEquation();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppTheme.FAB_dark)),
                    child: Icon(Icons.backspace_rounded).centered(),
                  ).pOnly(left: 8),
                ),
                Expanded(
                  flex: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      addInEquation("+");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(context.cardColor)),
                    child: Text(
                      "+",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ).centered(),
                  ).pOnly(left: 8, right: 8),
                ),
              ],
            ),
          ).pOnly(bottom: 8),
        ],
      ).pOnly(top: 45),
    );
  }
}
