import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:pocketify/models/expense_model.dart';
import 'package:pocketify/screens/calculator_screen.dart';
import 'package:pocketify/screens/edit_screen.dart';
import 'package:pocketify/screens/expense_visualization_screen.dart';
import 'package:pocketify/screens/homescreen.dart';
import 'package:pocketify/screens/splash_screen.dart';
import 'package:pocketify/screens/vip_subscription_screen.dart';
import 'package:pocketify/utils/ExpenseNotifier.dart';
import 'package:pocketify/utils/routes.dart';
import 'package:pocketify/utils/themes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ExpenseNotifier.initDatabase();
  runApp(
    ChangeNotifierProvider<ExpenseNotifier>(
      create: (_) {
        return ExpenseNotifier();
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: AppTheme.darkTheme(context),
      theme: AppTheme.lightTheme(context),
      home: SplashScreen(),
      routes: {
        Routes.HomeScreenRoute: (context) {
          return HomeScreen();
        },
        /*Routes.CalculatorScreen: (context) {
          return CalculatorScreen();
        },*/
        /* Routes.EditScreen: (context) {
          return EditScreen(
            expense: ExpenseModel(
                id: 3,
                title: "Health",
                icon: AppIcons.health,
                expense: 500,
                date: DateTime(2022, 1, 30),
                category: "Expenses",
                remark: "At Ajay Kumar Rai's clinic"),
          );
        },*/
        Routes.VIPSubscriptionScreen: (context) {
          return VIPSubscriptionScreen();
        },
        Routes.ExpenseVisualizationScreen: (context) {
          return ExpenseVisualizationScreen();
        }
      },
    );
  }
}
