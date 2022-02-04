import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketify/models/expense_model.dart';
import 'package:pocketify/utils/themes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';

class VIPSubscriptionScreen extends StatelessWidget {
  final Key _snackbarKey = UniqueKey();
  VIPSubscriptionScreen({Key? key}) : super(key: key);

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
      ),
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: context.screenWidth,
              height: 100,
              child: Lottie.asset(
                "assets/pro_version.json",
                repeat: true,
              ),
            ).p8(),
            "Upgrade professional".text.size(20).make(),
            "₹ 130.00/Month".text.size(15).color(Vx.gray500).make(),
            SizedBox(
              child: Container(
                color: AppTheme.BASE_dullAccent,
              ),
              width: context.screenWidth,
              height: 5,
            ).pOnly(top: 10),
            ListTile(
              leading: Image.asset(
                AppIcons.block_ads,
                color: context.cardColor,
                height: 40,
                width: 40,
              ),
              title: "Remove all Ads".text.size(16).make(),
              subtitle: "Remove and enjoy using this app without annoying ads."
                  .text
                  .size(10)
                  .color(Vx.gray500)
                  .make(),
            ).pOnly(left: 8, right: 8, top: 8),
            ListTile(
              leading: Icon(
                Icons.color_lens_outlined,
                size: 40,
                color: context.cardColor,
              ),
              title: "Switch Colors".text.size(16).make(),
              subtitle: "You can select different display colors for the App."
                  .text
                  .size(10)
                  .color(Vx.gray500)
                  .make(),
            ).pSymmetric(h: 8),
            ListTile(
              leading: Image.asset(
                AppIcons.xls,
                color: context.cardColor,
                height: 40,
                width: 40,
              ),
              title: "Excel Export".text.size(16).make(),
              subtitle: "You can export the data to an Excel file"
                  .text
                  .size(10)
                  .color(Vx.gray500)
                  .make(),
            ).pSymmetric(h: 8),
            ListTile(
              leading: Icon(
                Icons.dark_mode_rounded,
                color: context.cardColor,
                size: 40,
              ),
              title: "Dark Theme".text.size(16).make(),
              subtitle: "Remove and enjoy using this app without annoying ads."
                  .text
                  .size(10)
                  .color(Vx.gray500)
                  .make(),
            ).pSymmetric(h: 8),
            ListTile(
              leading: Icon(
                CupertinoIcons.search,
                color: context.cardColor,
                size: 40,
              ),
              title: "Search".text.size(16).make(),
              subtitle: "You can search all data"
                  .text
                  .size(10)
                  .color(Vx.gray500)
                  .make(),
            ).pSymmetric(h: 8),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: "Sorry! Payment has not been enabled yet"
                      .text
                      .size(12)
                      .color(Colors.black)
                      .bold
                      .make()
                      .p0(),
                  backgroundColor: Vx.purple100,
                  action: SnackBarAction(
                    label: "✖",
                    textColor: context.cardColor,
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ));
              },
              child: "Pay".text.size(20).make().p2(),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(context.cardColor),
                minimumSize:
                    MaterialStateProperty.all(Size(context.screenWidth, 30)),
              ),
            ).pSymmetric(h: 8, v: 10)
          ],
        ),
      ),
    );
  }
}
