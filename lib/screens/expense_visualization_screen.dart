import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ExpenseVisualizationScreen extends StatelessWidget {
  const ExpenseVisualizationScreen({Key? key}) : super(key: key);

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
          children: [],
        ),
      ),
    );
  }
}
