import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:pocketify/models/expense_model.dart';
import 'package:pocketify/utils/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class CalculatorScreen extends StatefulWidget {
  CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>
    with TickerProviderStateMixin {
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

  bool categoryVisible = false;

  //Edit utility variables
  String categorySelected = "Food";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _fabPosition = _initialSheetChildSize * context.screenHeight;
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        categoryVisible = !categoryVisible;
                      });
                      if (categoryVisible) {
                        showModalBottomSheet(
                            transitionAnimationController: AnimationController(
                                vsync: this,
                                duration: Duration(milliseconds: 600),
                                animationBehavior: AnimationBehavior.normal),
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 350,
                                width: context.screenWidth,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: context.screenWidth,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TabBar(
                                          controller: tabController,
                                          isScrollable: true,
                                          indicator: UnderlineTabIndicator(
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: context.cardColor,
                                            ),
                                          ),
                                          labelPadding:
                                              const EdgeInsets.only(right: 20),
                                          indicatorPadding:
                                              const EdgeInsets.only(right: 20),
                                          labelColor: context.cardColor,
                                          unselectedLabelColor: Vx.gray400,
                                          tabs: [
                                            Text(
                                              "EXPENSES",
                                            ),
                                            "INCOME".text.make()
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 300,
                                      width: context.screenWidth,
                                      child: TabBarView(
                                        controller: tabController,
                                        children: [
                                          ExpenseCategoryListBuilder(
                                            selectedExpenseCategoryCallback:
                                                (String
                                                    expenseCategorySelected) {
                                              this.categorySelected =
                                                  expenseCategorySelected;
                                              setState(() {});
                                            },
                                          ),
                                          IncomeCategoryListBuilder(
                                            selectedIncomeCategoryCallback:
                                                (String
                                                    IncomeCategorySelected) {
                                              this.categorySelected =
                                                  IncomeCategorySelected;
                                              setState(() {});
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      }
                    },
                    child: Image.asset(
                      "assets/icons/${categorySelected.toLowerCase()}.png",
                      height: 45,
                      width: 45,
                    ).pOnly(left: 10),
                  ),
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

class CategoryBottomSheet extends StatelessWidget {
  double height = 0;
  CategoryBottomSheet({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 3),
      curve: Curves.easeInCubic,
      color: Colors.white,
      width: context.screenWidth,
      height: height,
    );
  }
}

class ExpenseCategoryListBuilder extends StatefulWidget {
  final void Function(String) selectedExpenseCategoryCallback;
  const ExpenseCategoryListBuilder(
      {Key? key, required this.selectedExpenseCategoryCallback})
      : super(key: key);

  @override
  State<ExpenseCategoryListBuilder> createState() =>
      _ExpenseCategoryListBuilderState();
}

class _ExpenseCategoryListBuilderState
    extends State<ExpenseCategoryListBuilder> {
  int selectedCategory = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ExpenseModel.ExpenseCategoryList.length,
        itemBuilder: (context, index) {
          String category = ExpenseModel.ExpenseCategoryList[index];
          return Column(
            children: [
              ListTile(
                leading: Image.asset(
                  "assets/icons/${category.toLowerCase()}.png",
                  height: 25,
                  width: 25,
                ),
                title: Text(category),
                trailing: Visibility(
                  visible: index == selectedCategory,
                  child: Icon(
                    Icons.done,
                    color: context.cardColor,
                  ),
                ),
                onTap: () {
                  selectedCategory = index;
                  widget.selectedExpenseCategoryCallback(category);
                  setState(() {});
                },
              ),
              Divider(
                height: 3,
              )
            ],
          );
        });
  }
}

class IncomeCategoryListBuilder extends StatefulWidget {
  final void Function(String) selectedIncomeCategoryCallback;
  const IncomeCategoryListBuilder(
      {Key? key, required this.selectedIncomeCategoryCallback})
      : super(key: key);

  @override
  State<IncomeCategoryListBuilder> createState() =>
      _IncomeCategoryListBuilderState();
}

class _IncomeCategoryListBuilderState extends State<IncomeCategoryListBuilder> {
  int selectedCategory = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ExpenseModel.ExpenseCategoryList.length,
        itemBuilder: (context, index) {
          String category = ExpenseModel.ExpenseCategoryList[index];
          return Column(
            children: [
              ListTile(
                leading: Image.asset(
                  "assets/icons/${category.toLowerCase()}.png",
                  height: 25,
                  width: 25,
                ),
                title: Text(category),
                trailing: Visibility(
                  visible: index == selectedCategory,
                  child: Icon(
                    Icons.done,
                    color: context.cardColor,
                  ),
                ),
                onTap: () {
                  selectedCategory = index;
                  widget.selectedIncomeCategoryCallback(category);
                  setState(() {});
                },
              ),
              Divider(
                height: 3,
              )
            ],
          );
        });
  }
}
