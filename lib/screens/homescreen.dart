import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:pocketify/utils/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentIndex;
  late ScrollController _scrollController;
  double _scrollControlOffset = 0.0;

  _scrollListener() {
    _scrollControlOffset = _scrollController.offset;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: SafeArea(
              child: Container(
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
                          "2022-01",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          "Balance",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ).pOnly(left: 8),
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
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.75,
            maxChildSize: 1,
            builder: (context, controller) => ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Container(
                color: Colors.white,
                child: BottomCardHomeScreen(controller: controller),
              ),
            ),
          ),
          PreferredSize(
              child: FadeAppBar(scrollOffset: _scrollControlOffset),
              preferredSize: Size(MediaQuery.of(context).size.width, 30))
        ],
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
                color: Theme.of(context).cardColor,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
              )),
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
  }
}

class BottomCardHomeScreen extends StatelessWidget {
  ScrollController controller;
  BottomCardHomeScreen({Key? key, required this.controller})
      : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            color: Vx.white,
            elevation: 10,
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
                  gradient: LinearGradient(
                      colors: [AppTheme.progressBase, AppTheme.progressMarker]),
                  value: 0.55,
                ).p8(),
              ],
            ),
          ).p(0),
          Column(
            children: [
              ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile();
                  }).h(100)
            ],
          )
        ],
      ),
    );
  }

  Future<void> getData() async {
    print("refreshed");
  }
}

class FadeAppBar extends StatelessWidget {
  final double scrollOffset;

  const FadeAppBar({
    Key? key,
    required this.scrollOffset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color:
          Colors.white.withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
    );
  }
}
