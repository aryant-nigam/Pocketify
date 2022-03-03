import 'dart:io';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocketify/models/expense_model.dart';
import 'package:pocketify/screens/budget_settings.dart';
import 'package:pocketify/screens/calculator_screen.dart';
import 'package:pocketify/utils/ExpenseNotifier.dart';
import 'package:pocketify/utils/custom_toast.dart';
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
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: ExpenseNotifier.themeManager.getTheme().cardColor));
        if (ExpenseNotifier.isLoaded) {
          print(ExpenseNotifier.themeManager.getThemeName());
          return Scaffold(
            key: scaffoldKey,
            drawer: CustomDrawerWidget(),
            drawerEnableOpenDragGesture: false,
            onDrawerChanged: (isOpen) {
              if (!isOpen)
                setState(() {
                  currentIndex = 0;
                });
            },
            body: Container(
              color: ExpenseNotifier.themeManager.getTheme().cardColor,
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
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    ExpenseNotifier.themeManager
                                                        .getTheme()
                                                        .toastBaseColor,
                                                    ExpenseNotifier.themeManager
                                                        .getTheme()
                                                        .cardColor
                                                  ]),
                                                  value: ExpenseNotifier
                                                                  .getMetaData()
                                                              .totalBudget ==
                                                          0.0
                                                      ? (ExpenseNotifier
                                                              .IncomeOfTheMonth +
                                                          ExpenseNotifier
                                                              .ExpenseOfTheMonth)
                                                      : ((ExpenseNotifier
                                                                  .IncomeOfTheMonth +
                                                              ExpenseNotifier
                                                                  .ExpenseOfTheMonth) /
                                                          ExpenseNotifier
                                                                  .getMetaData()
                                                              .totalBudget))
                                              .p4(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      controller: scrollcontroller,
                                      itemCount:
                                          ExpenseNotifier.dateList.length,
                                      itemBuilder: (context, int index) {
                                        return DateWiseExpenseWidget(
                                            date:
                                                ExpenseNotifier.dateList[index],
                                            expenseList: expenseNotifier.Filter(
                                                ExpenseNotifier
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
                  backgroundColor:
                      ExpenseNotifier.themeManager.getTheme().cardColor,
                  icon: Icon(
                    Icons.home,
                    color: Vx.gray400,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: ExpenseNotifier.themeManager.getTheme().cardColor,
                  ),
                  title: Text(
                    "Home",
                    style:
                        TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
                  ),
                ),
                BubbleBottomBarItem(
                    backgroundColor:
                        ExpenseNotifier.themeManager.getTheme().cardColor,
                    icon: Icon(
                      Icons.menu,
                      color: Vx.gray300,
                    ),
                    activeIcon: Icon(
                      Icons.menu,
                      color: ExpenseNotifier.themeManager.getTheme().cardColor,
                    ),
                    title: Text(
                      "Category",
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily),
                    )),
                BubbleBottomBarItem(
                    backgroundColor:
                        ExpenseNotifier.themeManager.getTheme().cardColor,
                    icon: Icon(
                      CupertinoIcons.chart_pie_fill,
                      color: Vx.gray300,
                    ),
                    activeIcon: Icon(
                      CupertinoIcons.chart_pie_fill,
                      color: ExpenseNotifier.themeManager.getTheme().cardColor,
                    ),
                    title: Text(
                      "Visualize",
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily),
                    )),
                BubbleBottomBarItem(
                    backgroundColor:
                        ExpenseNotifier.themeManager.getTheme().cardColor,
                    icon: Icon(
                      CupertinoIcons.star_circle,
                      color: Vx.gray300,
                    ),
                    activeIcon: Icon(
                      CupertinoIcons.star_circle,
                      color: ExpenseNotifier.themeManager.getTheme().cardColor,
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
              backgroundColor:
                  ExpenseNotifier.themeManager.getTheme().cardColor,
              child: Icon(
                CupertinoIcons.add,
                size: 35,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
          );
        } else
          return Scaffold(
            body: Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  color: Vx.orange100,
                ),
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

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  int _selectedThemeIndex = ExpenseNotifier.themeManager.currentThemeIndex;
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseNotifier>(
        builder: (context, expenseNotifier, child) {
      return Drawer(
        backgroundColor: ExpenseNotifier.themeManager.getTheme().cardColor,
        child: Stack(
          children: [
            VxArc(
              height: 170,
              child: Container(
                height: 210,
                color: ExpenseNotifier.themeManager.getTheme().toastBaseColor,
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
                      child: Lottie.asset("assets/piggie.json").pOnly(left: 10))
                  .p0(),
            ),
            Positioned(
                top: 240,
                child: Container(
                  width: double.maxFinite,
                  color: context.cardColor,
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/block_ads.png",
                              height: 30,
                              width: 30,
                              color: ExpenseNotifier.themeManager
                                  .getTheme()
                                  .toastBaseColor,
                            ).pOnly(right: 15),
                            "Remove all Ads"
                                .text
                                .color(ExpenseNotifier.themeManager
                                    .getTheme()
                                    .toastBaseColor)
                                .make(),
                            Image.asset(
                              "assets/icons/vip.png",
                              height: 25,
                              width: 25,
                            ).pOnly(left: 20)
                          ],
                        ).pOnly(left: 20, bottom: 15),
                      ),
                      GestureDetector(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (context, updateDialogState) {
                                      return AlertDialog(
                                        titlePadding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        title: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                        height: 50,
                                                        width: 50,
                                                        child: Lottie.asset(
                                                            "assets/theme.json"))
                                                    .pOnly(top: 5),
                                                Text(
                                                  "Select your theme",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ).pOnly(bottom: 5, top: 10),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 1.5,
                                              color: Vx.gray300,
                                            )
                                          ],
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        content: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 6,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      toggleable: true,
                                                      value: index,
                                                      groupValue:
                                                          _selectedThemeIndex,
                                                      activeColor:
                                                          ExpenseNotifier
                                                              .themeManager
                                                              .getThemeCardColor(
                                                                  index),
                                                      onChanged: (int? value) {
                                                        updateDialogState(() {
                                                          _selectedThemeIndex =
                                                              value!;
                                                        });
                                                        setState(() {
                                                          _selectedThemeIndex =
                                                              value!;
                                                        });
                                                      },
                                                    ).pOnly(right: 10),
                                                    "${ExpenseNotifier.themeManager.getFormattedThemeName(index)}"
                                                        .text
                                                        .size(15)
                                                        .bold
                                                        .color(ExpenseNotifier
                                                            .themeManager
                                                            .getThemeCardColor(
                                                                index))
                                                        .make(),
                                                  ],
                                                ),
                                              );
                                            }).p0(),
                                        actionsPadding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                expenseNotifier.changeTheme(
                                                    _selectedThemeIndex);
                                                Navigator.pop(context, true);
                                              },
                                              child: "CHANGE THEME"
                                                  .text
                                                  .color(ExpenseNotifier
                                                      .themeManager
                                                      .getTheme()
                                                      .cardColor)
                                                  .size(15)
                                                  .bold
                                                  .make())
                                        ],
                                      );
                                    },
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.color_lens_outlined,
                                color: ExpenseNotifier.themeManager
                                    .getTheme()
                                    .toastBaseColor,
                                size: 30,
                              ).pOnly(right: 15),
                              "Switch Colors"
                                  .text
                                  .color(ExpenseNotifier.themeManager
                                      .getTheme()
                                      .toastBaseColor)
                                  .make(),
                              Image.asset(
                                "assets/icons/vip.png",
                                height: 25,
                                width: 25,
                              ).pOnly(left: 30)
                            ],
                          ).pOnly(left: 20, bottom: 15)),
                      GestureDetector(
                        onTap: () async {
                          var directory;
                          {
                            if (Platform.isAndroid) {
                              if (await _requestPermission(
                                  Permission.storage)) {
                                try {
                                  directory =
                                      await getExternalStorageDirectory();
                                  if (directory != null) {
                                    expenseNotifier.createExcel(directory);
                                  } else {
                                    CustomToast(
                                            context: context,
                                            type: 1,
                                            msg:
                                                "Error while creating .xlsx file !",
                                            backgroundColor: Vx.rose300,
                                            textColor: Vx.rose800)
                                        .create();
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }
                            }
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              AppIcons.xls,
                              height: 30,
                              width: 30,
                              color: ExpenseNotifier.themeManager
                                  .getTheme()
                                  .toastBaseColor,
                            ).pOnly(right: 15),
                            "Excel Export"
                                .text
                                .color(ExpenseNotifier.themeManager
                                    .getTheme()
                                    .toastBaseColor)
                                .make(),
                            Image.asset(
                              "assets/icons/vip.png",
                              height: 25,
                              width: 25,
                            ).pOnly(left: 43)
                          ],
                        ).pOnly(left: 20, bottom: 15),
                      ),
                      GestureDetector(
                          child: Row(
                        children: [
                          Icon(
                            Icons.dark_mode_rounded,
                            color: ExpenseNotifier.themeManager
                                .getTheme()
                                .toastBaseColor,
                            size: 30,
                          ).pOnly(right: 15),
                          "Dark Theme"
                              .text
                              .color(ExpenseNotifier.themeManager
                                  .getTheme()
                                  .toastBaseColor)
                              .make(),
                          Image.asset(
                            "assets/icons/vip.png",
                            height: 25,
                            width: 25,
                          ).pOnly(left: 40)
                        ],
                      ).pOnly(left: 20, bottom: 15)),
                      GestureDetector(
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.search,
                              color: ExpenseNotifier.themeManager
                                  .getTheme()
                                  .toastBaseColor,
                              size: 30,
                            ).pOnly(right: 15),
                            "Search"
                                .text
                                .color(ExpenseNotifier.themeManager
                                    .getTheme()
                                    .toastBaseColor)
                                .make(),
                            Image.asset(
                              "assets/icons/vip.png",
                              height: 25,
                              width: 25,
                            ).pOnly(left: 73)
                          ],
                        ).pOnly(left: 20, bottom: 15),
                      ),
                      10.heightBox,
                      GestureDetector(
                          child: Row(
                        children: [
                          Icon(
                            Icons.backup,
                            color: ExpenseNotifier.themeManager
                                .getTheme()
                                .toastBaseColor,
                            size: 30,
                          ).pOnly(right: 15),
                          "Backup/Restore"
                              .text
                              .color(ExpenseNotifier.themeManager
                                  .getTheme()
                                  .toastBaseColor)
                              .make()
                        ],
                      ).pOnly(left: 20, bottom: 15)),
                      GestureDetector(
                          child: Row(
                        children: [
                          Icon(
                            Icons.update,
                            color: ExpenseNotifier.themeManager
                                .getTheme()
                                .toastBaseColor,
                            size: 30,
                          ).pOnly(right: 15),
                          "Check Update"
                              .text
                              .color(ExpenseNotifier.themeManager
                                  .getTheme()
                                  .toastBaseColor)
                              .make()
                        ],
                      ).pOnly(left: 20, bottom: 15)),
                      GestureDetector(
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.star_fill,
                              color: ExpenseNotifier.themeManager
                                  .getTheme()
                                  .toastBaseColor,
                              size: 30,
                            ).pOnly(right: 15),
                            "Grade"
                                .text
                                .color(ExpenseNotifier.themeManager
                                    .getTheme()
                                    .toastBaseColor)
                                .make(),
                          ],
                        ).pOnly(left: 20, bottom: 15),
                      ),
                      GestureDetector(
                          child: Row(
                        children: [
                          Icon(
                            Icons.share,
                            color: ExpenseNotifier.themeManager
                                .getTheme()
                                .toastBaseColor,
                            size: 30,
                          ).pOnly(right: 15),
                          "Share"
                              .text
                              .color(ExpenseNotifier.themeManager
                                  .getTheme()
                                  .toastBaseColor)
                              .make()
                        ],
                      ).pOnly(left: 20, bottom: 15)),
                      GestureDetector(
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              color: ExpenseNotifier.themeManager
                                  .getTheme()
                                  .toastBaseColor,
                              size: 30,
                            ).pOnly(right: 15),
                            "Settings"
                                .text
                                .color(ExpenseNotifier.themeManager
                                    .getTheme()
                                    .toastBaseColor)
                                .make()
                          ],
                        ).pOnly(left: 20, bottom: 15),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      );
    });
  }

  Future<bool> _requestPermission(Permission permission) async {
    var status = await permission.status;
    if (status.isGranted) {
      return true;
    } else {
      var newStatus = await permission.request();
      if (newStatus == PermissionStatus.granted)
        return true;
      else
        return false;
    }
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
            color: ExpenseNotifier.themeManager.getTheme().cardColor,
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
                  "${ExpenseNotifier.ExpenseOfTheMonth + ExpenseNotifier.IncomeOfTheMonth}",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary),
                ).pSymmetric(h: 15),
                Row(
                  children: [
                    Text(
                      "Expense:  ${ExpenseNotifier.ExpenseOfTheMonth}",
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
                      "Income:  ${ExpenseNotifier.IncomeOfTheMonth}",
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
      print("in datewise expense wid${expenseList.length}");
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
                    "Expense: ${ExpenseNotifier.ExpenseOfTheMonth}",
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
                        "Income:  ${ExpenseNotifier.IncomeOfTheMonth}",
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
