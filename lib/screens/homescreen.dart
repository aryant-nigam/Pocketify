import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pocketify/models/expense_model.dart';
import 'package:pocketify/screens/budget_settings.dart';
import 'package:pocketify/screens/calculator_screen.dart';
import 'package:pocketify/utils/ExpenseNotifier.dart';
import 'package:pocketify/utils/initialise_expenses_lists.dart';
import 'package:pocketify/utils/routes.dart';
import 'package:pocketify/utils/themes.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/app_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentIndex = 0;
  late ScrollController _scrollController;
  late double _scrollControlOffset = 0.0;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  _scrollListener() {
    _scrollControlOffset = _scrollController.offset;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseNotifier>(
      builder: (context, expenseNotifier, child) {
        if (ExpenseNotifier.isLoaded)
          return Scaffold(
            key: scaffoldKey,
            drawer: Drawer(
              backgroundColor: context.cardColor,
              child: Stack(
                children: [
                  VxArc(
                    height: 170,
                    child: Container(
                      height: 210,
                      color: Vx.purple100,
                    ),
                  ),
                  Lottie.asset(
                    "assets/coins.json",
                  ),
                  Positioned(
                    right: 71,
                    top: 76,
                    child: SizedBox(
                            height: 150,
                            width: 150,
                            child: Lottie.asset("assets/piggie.json")
                                .pOnly(left: 10))
                        .p0(),
                  ),
                  Positioned(
                      top: 240,
                      child: Container(
                        width: double.maxFinite,
                        color: context.cardColor,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/icons/block_ads.png",
                                  height: 30,
                                  width: 30,
                                  color: Vx.purple100,
                                ).pOnly(right: 15),
                                "Remove all Ads"
                                    .text
                                    .color(Vx.purple100)
                                    .make(),
                                Image.asset(
                                  "assets/icons/vip.png",
                                  height: 25,
                                  width: 25,
                                ).pOnly(left: 20)
                              ],
                            ).pOnly(left: 20, bottom: 15),
                            Row(
                              children: [
                                Icon(
                                  Icons.color_lens_outlined,
                                  color: Vx.purple100,
                                  size: 30,
                                ).pOnly(right: 15),
                                "Switch Colors".text.color(Vx.purple100).make(),
                                Image.asset(
                                  "assets/icons/vip.png",
                                  height: 25,
                                  width: 25,
                                ).pOnly(left: 30)
                              ],
                            ).pOnly(left: 20, bottom: 15),
                            Row(
                              children: [
                                Image.asset(
                                  AppIcons.xls,
                                  height: 30,
                                  width: 30,
                                  color: Vx.purple100,
                                ).pOnly(right: 15),
                                "Excel Export".text.color(Vx.purple100).make(),
                                Image.asset(
                                  "assets/icons/vip.png",
                                  height: 25,
                                  width: 25,
                                ).pOnly(left: 43)
                              ],
                            ).pOnly(left: 20, bottom: 15),
                            Row(
                              children: [
                                Icon(
                                  Icons.dark_mode_rounded,
                                  color: Vx.purple100,
                                  size: 30,
                                ).pOnly(right: 15),
                                "Dark Theme".text.color(Vx.purple100).make(),
                                Image.asset(
                                  "assets/icons/vip.png",
                                  height: 25,
                                  width: 25,
                                ).pOnly(left: 40)
                              ],
                            ).pOnly(left: 20, bottom: 15),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.search,
                                  color: Vx.purple100,
                                  size: 30,
                                ).pOnly(right: 15),
                                "Search".text.color(Vx.purple100).make(),
                                Image.asset(
                                  "assets/icons/vip.png",
                                  height: 25,
                                  width: 25,
                                ).pOnly(left: 73)
                              ],
                            ).pOnly(left: 20, bottom: 15),
                            10.heightBox,
                            Row(
                              children: [
                                Icon(
                                  Icons.backup,
                                  color: Vx.purple100,
                                  size: 30,
                                ).pOnly(right: 15),
                                "Backup/Restore".text.color(Vx.purple100).make()
                              ],
                            ).pOnly(left: 20, bottom: 15),
                            Row(
                              children: [
                                Icon(
                                  Icons.update,
                                  color: Vx.purple100,
                                  size: 30,
                                ).pOnly(right: 15),
                                "Check Update".text.color(Vx.purple100).make()
                              ],
                            ).pOnly(left: 20, bottom: 15),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.star_fill,
                                  color: Vx.purple100,
                                  size: 30,
                                ).pOnly(right: 15),
                                "Grade".text.color(Vx.purple100).make(),
                              ],
                            ).pOnly(left: 20, bottom: 15),
                            Row(
                              children: [
                                Icon(
                                  Icons.share,
                                  color: Vx.purple100,
                                  size: 30,
                                ).pOnly(right: 15),
                                "Share".text.color(Vx.purple100).make()
                              ],
                            ).pOnly(left: 20, bottom: 15),
                            Row(
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: Vx.purple100,
                                  size: 30,
                                ).pOnly(right: 15),
                                "Settings".text.color(Vx.purple100).make()
                              ],
                            ).pOnly(left: 20, bottom: 15),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            drawerEnableOpenDragGesture: false,
            onDrawerChanged: (isOpen) {
              if (!isOpen)
                setState(() {
                  currentIndex = 0;
                });
            },
            body: Container(
              color: context.cardColor,
              child: Stack(
                children: [
                  TopCardHomeScreen(),
                  NotificationListener<DraggableScrollableNotification>(
                    onNotification: (notification) {
                      _scrollControlOffset =
                          (notification.extent - notification.minExtent) /
                              (notification.maxExtent - notification.minExtent);
                      setState(() {});
                      return true;
                    },
                    child: DraggableScrollableSheet(
                        initialChildSize: .75,
                        minChildSize: .75,
                        builder: (BuildContext context,
                            ScrollController scrollcontroller) {
                          return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 70,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                      ),
                                      color: Vx.white,
                                      elevation: 3.5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return BudgetSettings();
                                              }));
                                            },
                                            child: "Budget Setting"
                                                .text
                                                .xl
                                                .fontWeight(FontWeight.bold)
                                                .make()
                                                .p8(),
                                          ),
                                          GradientProgressIndicator(
                                            gradient: LinearGradient(colors: [
                                              AppTheme.progressBase,
                                              AppTheme.progressMarker
                                            ]),
                                            value: (expenseNotifier
                                                    .IncomeOfTheMonth +
                                                expenseNotifier
                                                    .ExpenseOfTheMonth),
                                          ).p4(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      controller: scrollcontroller,
                                      itemCount:
                                          expenseNotifier.dateList.length,
                                      itemBuilder: (context, int index) {
                                        print(
                                            "Aryant ${myDateFormatter(expenseNotifier.expenseList[0].date)} "
                                            "    ${expenseNotifier.dateList[0]}  "
                                            " ${expenseNotifier.Filter(expenseNotifier.dateList[index]).length}");
                                        return DateWiseExpenseWidget(
                                            date:
                                                expenseNotifier.dateList[index],
                                            expenseList: expenseNotifier.Filter(
                                                expenseNotifier
                                                    .dateList[index]));
                                      }).pOnly(top: 30),
                                ],
                              ));
                        }),
                  ),
                  FadingAppBar(scrollOffset: _scrollControlOffset)
                ],
              ),
            ),
            bottomNavigationBar: BubbleBottomBar(
              backgroundColor: Vx.white,
              inkColor: Vx.white,
              hasNotch: false,
              hasInk: true,
              fabLocation: BubbleBottomBarFabLocation.end,
              currentIndex: currentIndex,
              onTap: changePage,
              opacity: 0.2,
              elevation: 8,
              tilesPadding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              items: [
                BubbleBottomBarItem(
                  backgroundColor: Theme.of(context).cardColor,
                  icon: Icon(
                    Icons.home,
                    color: Vx.gray400,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: context.cardColor,
                  ),
                  title: Text(
                    "Home",
                    style:
                        TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
                  ),
                ),
                BubbleBottomBarItem(
                    backgroundColor: Theme.of(context).cardColor,
                    icon: Icon(
                      Icons.menu,
                      color: Vx.gray300,
                    ),
                    activeIcon: Icon(
                      Icons.menu,
                      color: Theme.of(context).cardColor,
                    ),
                    title: Text(
                      "Category",
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily),
                    )),
                BubbleBottomBarItem(
                    backgroundColor: Theme.of(context).cardColor,
                    icon: Icon(
                      CupertinoIcons.chart_pie_fill,
                      color: Vx.gray300,
                    ),
                    activeIcon: Icon(
                      CupertinoIcons.chart_pie_fill,
                      color: Theme.of(context).cardColor,
                    ),
                    title: Text(
                      "Visualize",
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily),
                    )),
                BubbleBottomBarItem(
                    backgroundColor: Theme.of(context).cardColor,
                    icon: Icon(
                      CupertinoIcons.star_circle,
                      color: Vx.gray300,
                    ),
                    activeIcon: Icon(
                      CupertinoIcons.star_circle,
                      color: Theme.of(context).cardColor,
                    ),
                    title: Text(
                      "VIP",
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily),
                    ))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CalculatorScreen(
                            expenseModel:
                                ExpenseModel.getDefaultExpenseModel())));
              },
              backgroundColor: AppTheme.FAB_light,
              child: Icon(
                CupertinoIcons.add,
                size: 35,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
          );
        else
          return Scaffold(
            body: Container(
              child: CircularProgressIndicator(
                color: context.cardColor,
              ),
            ),
          );
      },
    );
  }

  changePage(int? index) {
    currentIndex = index!;
    setState(() {});
    if (currentIndex == 1) scaffoldKey.currentState?.openDrawer();
    if (currentIndex == 2)
      Navigator.pushNamed(context, Routes.ExpenseVisualizationScreen);
    if (currentIndex == 3)
      Navigator.pushNamed(context, Routes.VIPSubscriptionScreen);
  }
}

class TopCardHomeScreen extends StatelessWidget {
  const TopCardHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseNotifier>(
      builder: (context, expenseNotifier, child) {
        return SafeArea(
          child: Container(
            height: 150,
            color: context.cardColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.calendar,
                      color: Theme.of(context).colorScheme.secondary,
                    ).p8(),
                    7.widthBox,
                    Text(
                      "${DateFormat("yyyy-MM").format(DateTime.now())}   Balance",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ).pSymmetric(h: 5),
                Text(
                  "${expenseNotifier.ExpenseOfTheMonth + expenseNotifier.IncomeOfTheMonth}",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary),
                ).pSymmetric(h: 15),
                Row(
                  children: [
                    Text(
                      "Expense:  ${expenseNotifier.ExpenseOfTheMonth}",
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary),
                    ).pOnly(left: 15, right: 5),
                    /*    Text(
                    "-666",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary),
                  ).pSymmetric(h: 2)*/
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Income:  ${expenseNotifier.IncomeOfTheMonth}",
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary),
                    ).pOnly(left: 15, right: 5),
                    /*Text(
                    "0",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary),
                  ).pSymmetric(h: 2)*/
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class DateWiseExpenseWidget extends StatelessWidget {
  final String date;
  final List<ExpenseModel> expenseList;
  const DateWiseExpenseWidget(
      {Key? key, required this.date, required this.expenseList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseNotifier>(
        builder: (context, expenseNotifier, child) {
      //print("in datewise expense wid${expenseList.length}");
      InitialiseExpensesList initialiseExpensesList = InitialiseExpensesList(
        expenseList: this.expenseList,
      );
      return Container(
        color: Vx.white,
        child: Card(
          color: AppTheme.BASE_dullAccent,
          child: Column(
            children:
                initialiseExpensesList.initialiseAndFetchExpenses(context),
          ),
        ),
      ).p12();
    });
  }
}

class FadingAppBar extends StatelessWidget {
  final double scrollOffset;

  const FadingAppBar({
    Key? key,
    required this.scrollOffset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseNotifier>(
      builder: (context, expenseNotifier, child) {
        return Container(
          height: 85,
          color: context.cardColor.withOpacity(scrollOffset.toDouble()),
          child: SafeArea(
            child: Opacity(
              opacity: scrollOffset.toDouble(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Expense: ${expenseNotifier.ExpenseOfTheMonth}",
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary),
                  ).pOnly(right: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat("yyyy-MM").format(DateTime.now()),
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary),
                      ).pOnly(left: 15, right: 5),
                      Text(
                        "Income:  ${expenseNotifier.IncomeOfTheMonth}",
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary),
                      ).pOnly(left: 15, right: 5),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
