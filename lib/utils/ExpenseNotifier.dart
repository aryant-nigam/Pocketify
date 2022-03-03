import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocketify/utils/app_icons.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expense_model.dart';

class ExpenseNotifier extends ChangeNotifier {
  //SQflite operations
  static late Database _database;
  static bool isLoaded = false;
  //Defining the table name and the column name
  String budgetTable = "budgetTable";
  String col_expenseId = "expenseId";
  String col_title = "expenseTitle";
  String col_icon = "expenseIcon";
  String col_expense = "expenseExpense";
  String col_date = "expenseDate";
  String col_category = "expenseCategory";
  String col_remark = "expenseRemark";

  //Constructor for expense notifier
  ExpenseNotifier() {
    initList();
  }

  initList() async {
    print("Aryant done 0");

    //await database;
    print("Aryant done 1");
    dateList = [];
    var listOfMapOfExpenses = await _getExpenseMapList();
    print("Aryant done 2");
    expenseList = List.generate(listOfMapOfExpenses.length,
        (index) => ExpenseModel.fromMap(listOfMapOfExpenses[index]));
    print("Aryant done 3");
    fetchDatesFromExpenseList();
    print("Aryant done 4");
    initOtherMembers();
    print("Aryant done 5");
    isLoaded = true;
    print(expenseList.length);
    notifyListeners();
  }

  /*
  //function to get the instance of the database
  Future<Database> get database async {
    if (_database == null) _database = await _initializeDatabase();
    return _database;
  }

  //function to initialize the database foe the first time
  Future<Database> _initializeDatabase() async {
    //Get the directory for path for android and iOS to store database.
    String directory = await getDatabasesPath();
    String path = join(directory, "budget.db");
    //open/ create database at a given path
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }*/

  static initDatabase() async {
    String folder = await getDatabasesPath();
    String path = join(folder, "budget.db");
    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
    isLoaded = true;
  }

  static Future _onCreate(Database db, int newVersion) async {
    await db.execute("CREATE TABLE budgetTable"
        "("
        "expenseId INTEGER PRIMARY KEY,"
        "expenseTitle TEXT,"
        "expenseIcon TEXT,"
        "expenseExpense DECIMAL,"
        "expenseDate TEXT,"
        "expenseCategory TEXT,"
        "expenseRemark TEXT"
        ")");
  }

  //initializes the expense list and the date list

  //function to create the database if it does not pre-exists
  Future _createDB(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $budgetTable($col_expenseId INTEGER PRIMARY KEY,$col_title TEXT,$col_icon TEXT,$col_expense DECIMAL,$col_date DATETIME,$col_category TEXT,$col_remark TEXT)");
  }

  Future _closeDB() async {}
  //CRUD operations on the database

  //---------------------------------------------------------------------------------------------------------
  //Read Database:
  //---------------------------------------------------------------------------------------------------------
  Future<List<Map<String, dynamic>>> _getExpenseMapList() async {
    Database db = await _database;
    var result = db.rawQuery("SELECT * FROM $budgetTable");
    return result;
  }

  //---------------------------------------------------------------------------------------------------------
  //Insert in database:
  //---------------------------------------------------------------------------------------------------------
  Future<int> _insertExpenseInDatabase(ExpenseModel expense) async {
    Database db = await _database;
    var result = await db.insert(budgetTable, expense.toMap());
    return result;
  }

  //---------------------------------------------------------------------------------------------------------
  //Update in database:
  //---------------------------------------------------------------------------------------------------------
  Future<int> _updateExpenseInDatabase(ExpenseModel expense) async {
    Database db = await _database;
    var result = db.update(budgetTable, expense.toMap(),
        where: "$col_expenseId=?", whereArgs: [expense.id]);
    return result;
  }

  //---------------------------------------------------------------------------------------------------------
  //Delete in database:
  //---------------------------------------------------------------------------------------------------------
  Future<int> _deleteExpenseFromDatabase(int id) async {
    Database db = await _database;
    var result =
        db.rawDelete("DELETE FROM $budgetTable WHERE $col_expenseId = $id");
    return result;
  }

  //--------------------------------------------------------------------------------------------------------
  //Notifier Members
  //--------------------------------------------------------------------------------------------------------

  List<ExpenseModel> expenseList = []; // ExpenseModel.expenseList;
  List<String> dateList = []; //ExpenseModel.dateList;

  double ExpenseOfTheMonth = 0.0; //displayed on the top card of home screen
  double IncomeOfTheMonth = 0.0; //displayed on the top card of home screen

  //to fill dates with list of dates
  void fetchDatesFromExpenseList() {
    expenseList.forEach((expense) {
      if (!dateList.contains(myDateFormatter(expense.date)))
        dateList.add(myDateFormatter(expense.date));
    });
  }

  // initializes the total expense and income that are displayed on the top of the screen
  initOtherMembers() {
    expenseList.forEach((expense) {
      if (expense.date.month == DateTime.now().month &&
          expense.category == "Income") IncomeOfTheMonth += expense.expense;
      if (expense.date.month == DateTime.now().month &&
          expense.category == "Expenses") ExpenseOfTheMonth += expense.expense;
    });
    // for (var e in expenseList) {
    //   if (e.date.month == DateTime.now().month && e.category == "Income") {
    //     IncomeOfTheMonth += e.expense;
    //   }
    //   if (e.date.month == DateTime.now().month && e.category == "Expenses") {
    //     ExpenseOfTheMonth += e.expense;
    //   }
    // }
  }

  //to change the global total expense and the income on addition and deletion in the current month
  updateMonthlyExpenseAndIncome(ExpenseModel e, int action) {
    if (action == 1) {
      if (e.date.month == DateTime.now().month && e.category == "Income") {
        IncomeOfTheMonth += e.expense;
      }
      if (e.date.month == DateTime.now().month && e.category == "Expenses") {
        ExpenseOfTheMonth += e.expense;
      }
    }
    if (action == -1) {
      if (e.date.month == DateTime.now().month && e.category == "Income") {
        IncomeOfTheMonth -= e.expense;
      }
      if (e.date.month == DateTime.now().month && e.category == "Expenses") {
        ExpenseOfTheMonth -= e.expense;
      }
    }
  }

  //add the expense to the list
  Future addExpenses(ExpenseModel expense) async {
    if (!dateList.contains(myDateFormatter(expense.date)))
      dateList.add(myDateFormatter(expense.date));

    updateMonthlyExpenseAndIncome(expense, 1);

    expense.id = DateTime.now().microsecondsSinceEpoch;
    expenseList.add(expense);

    notifyListeners();

    await _insertExpenseInDatabase(expense);

    print("added");

    return 1;
  }

  //delete expense from the list
  void deleteExpenses(ExpenseModel expense) async {
    updateMonthlyExpenseAndIncome(getObjectWith(expense.id)!, -1);

    expenseList.removeWhere((item) => item.id == expense.id);
    await _deleteExpenseFromDatabase(expense.id);
    notifyListeners();
  }

  //update expense in the list
  void updateExpenses(ExpenseModel expense) async {
    deleteExpenses(expense);
    addExpenses(expense);
    await _updateExpenseInDatabase(expense);
    notifyListeners();
  }

  //to segregate the expense list on the basis of the list
  List<ExpenseModel> Filter(String formattedDate) {
    List<ExpenseModel> listOfDate = [];
    ExpenseModel.expenseList.forEach((expense) {
      if (myDateFormatter(expense.date) == formattedDate)
        listOfDate.add(expense);
    });
    return listOfDate;
  }

  ExpenseModel? getObjectWith(int id) {
    for (var expense in expenseList) if (expense.id == id) return expense;
  }
}
