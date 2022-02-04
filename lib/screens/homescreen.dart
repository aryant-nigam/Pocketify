import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:pocketify/models/expense_model.dart';
import 'package:pocketify/utils/initialise_expenses_lists.dart';
import 'package:pocketify/utils/routes.dart';
import 'package:pocketify/utils/themes.dart';
import 'package:velocity_x/velocity_x.dart';

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
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        backgroundColor: context.cardColor,
      ),
      onDrawerChanged: (isOpen) {},
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "Budget Setting"
                                        .text
                                        .xl
                                        .fontWeight(FontWeight.bold)
                                        .make()
                                        .p8(),
                                    GradientProgressIndicator(
                                      gradient: LinearGradient(colors: [
                                        AppTheme.progressBase,
                                        AppTheme.progressMarker
                                      ]),
                                      value: 0.55,
                                    ).p4(),
                                  ],
                                ),
                              ),
                            ),
                            ListView.builder(
                                controller: scrollcontroller,
                                itemCount: ExpenseModel.dateList.length,
                                itemBuilder: (context, int index) {
                                  ExpenseModel
                                      .expenseMap[ExpenseModel.dateList[index]];
                                  return DateWiseExpenseWidget(
                                      date: ExpenseModel.dateList[index]);
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
              Icons.menu,
              color: Vx.gray400,
            ),
            activeIcon: Icon(
              Icons.menu,
              color: context.cardColor,
            ),
            title: Text(
              "Home",
              style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
            ),
          ),
          BubbleBottomBarItem(
              backgroundColor: Theme.of(context).cardColor,
              icon: Icon(
                Icons.dashboard_rounded,
                color: Vx.gray300,
              ),
              activeIcon: Icon(
                Icons.dashboard_rounded,
                color: Theme.of(context).cardColor,
              ),
              title: Text(
                "Category",
                style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
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
                style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
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
                style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.FAB_light,
        child: Icon(
          CupertinoIcons.add,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  changePage(int? index) {
    currentIndex = index!;
    setState(() {});
    if (currentIndex == 0) scaffoldKey.currentState?.openDrawer();
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
                10.widthBox,
                Text(
                  "2022-01  Balance",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
            Text(
              "-666",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary),
            ).pSymmetric(h: 15),
            Row(
              children: [
                Text(
                  "Expense:",
                  style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary),
                ).pOnly(left: 15, right: 5),
                Text(
                  "-666",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary),
                ).pSymmetric(h: 2)
              ],
            ),
            Row(
              children: [
                Text(
                  "Income:",
                  style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary),
                ).pOnly(left: 15, right: 5),
                Text(
                  "0",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary),
                ).pSymmetric(h: 2)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DateWiseExpenseWidget extends StatelessWidget {
  final DateTime date;
  const DateWiseExpenseWidget({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Vx.white,
      child: Card(
        color: AppTheme.BASE_dullAccent,
        child: Column(
          children:
              InitialiseExpensesList.initialiseAndFetchExpenses(date, context),
        ),
      ),
    ).p12();
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
                "Expense: -4200",
                style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary),
              ).pOnly(right: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2022-01",
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary),
                  ).pOnly(left: 15, right: 5),
                  Text(
                    "Income:0",
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
  }
}

/*class BottomCardHomeScreen extends StatelessWidget {
  BottomCardHomeScreen({
    Key? key,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: ExpenseModel.dateList.length,
              itemBuilder: (context, index) {
                ExpenseModel.expenseMap[ExpenseModel.dateList[index]];
                return DateWiseExpenseWidget(
                    date: ExpenseModel.dateList[index]);
              })
        ],
      ),
    );
  }

  Future<void> getData() async {
    print("refreshed");
  }
}*/
