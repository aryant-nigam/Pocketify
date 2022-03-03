import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocketify/utils/app_icons.dart';
import 'package:pocketify/utils/theme_manager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import '../models/expense_model.dart';
import 'ExpenseNotifier.dart';

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
    var db = await getDatabase();
    //await database;
    dateList = [];
    _listOfMapOfExpenses = await _getExpenseMapList();
    print(_listOfMapOfExpenses);
    expenseList = List.generate(_listOfMapOfExpenses.length,
        (index) => ExpenseModel.fromMap(_listOfMapOfExpenses[index]));
    fetchDatesFromExpenseList();
    initOtherMembers();
    _budgetMetaData = await _getMetaDataDatabase();
    themeManager.changeTheme(_budgetMetaData.themeIndex);

    print("current theme :${themeManager.getThemeName()}");
    // print(_budgetMetaData.totalBudget);
    // print("loaded meta");
    isLoaded = true;

    notifyListeners();
  }

  //function to get the instance of the database
  Future<Database> getDatabase() async {
    if (_database == null) _database = await initDatabase();
    return _database;
  }

  static initDatabase() async {
    String folder = await getDatabasesPath();
    String path = join(folder, "budget.db");
    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
    //isLoaded = true;
  }

  static Future _onCreate(Database db, int newVersion) async {
    //print("EN: onCreate-start");
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
    print("creating meta");
    await db.execute("CREATE TABLE budgetMetaDataTable "
        "("
        "metaDataId INTEGER PRIMARY KEY,"
        "totalBudget DECIMAL,"
        "endDate TEXT,"
        "isVip INTEGER,"
        "themeIndex INTEGER"
        ")");
    await db.insert("budgetMetaDataTable", _budgetMetaData.toMap());
    //print("EN: onCreate-end");
  }

  //initializes the expense list and the date list

  //function to create the database if it does not pre-exists

  Future _closeDB() async {}
  //CRUD operations on the database

  //---------------------------------------------------------------------------------------------------------
  //Read Database:
  //---------------------------------------------------------------------------------------------------------
  Future<List<Map<String, dynamic>>> _getExpenseMapList() async {
    Database db = await getDatabase();
    var result = db.rawQuery("SELECT * FROM $budgetTable");
    return result;
  }

  //---------------------------------------------------------------------------------------------------------
  //Insert in database:
  //---------------------------------------------------------------------------------------------------------
  Future<int> _insertExpenseInDatabase(ExpenseModel expense) async {
    Database db = await getDatabase();
    var result = await db.insert(budgetTable, expense.toMap());
    return result;
  }

  //---------------------------------------------------------------------------------------------------------
  //Update in database:
  //---------------------------------------------------------------------------------------------------------
  Future<int> _updateExpenseInDatabase(ExpenseModel expense) async {
    Database db = await getDatabase();
    var result = db.update(budgetTable, expense.toMap(),
        where: "$col_expenseId=?", whereArgs: [expense.id]);
    return result;
  }

  //---------------------------------------------------------------------------------------------------------
  //Delete in database:
  //---------------------------------------------------------------------------------------------------------
  Future<int> _deleteExpenseFromDatabase(int id) async {
    Database db = await getDatabase();
    var result =
        db.rawDelete("DELETE FROM $budgetTable WHERE $col_expenseId = $id");
    return result;
  }

  //---------------------------------------------------------------------------------------------------------
  //Update Metadata in database:
  //---------------------------------------------------------------------------------------------------------
  Future<int> _updateMetaDataDatabase() async {
    //print("_updateMetaData");
    Database db = await getDatabase();
    int i = await db.update("budgetMetaDataTable", _budgetMetaData.toMap(),
        where: "metaDataId = ?", whereArgs: [1000]);
    //print("i: $i");
    _budgetMetaData = await _getMetaDataDatabase();
    return i;
  }

  //---------------------------------------------------------------------------------------------------------
  //get Metadata in database:
  //---------------------------------------------------------------------------------------------------------
  Future<BudgetMetaData> _getMetaDataDatabase() async {
    Database db = await getDatabase();
    var result = await db
        .rawQuery("SELECT * FROM budgetMetaDataTable WHERE metaDataId = 1000");
    print("null result: ${result == null}");
    print("length : ${result.length}");
    print("id: ${result[0]["metaDataId"] is Object}");
    print("total budget: ${result[0]["totalBudget"]}");
    print("endDate: ${result[0]["endDate"]}");
    print("isVip: ${result[0]["isVip"]}");
    print("isVip: ${result[0]["isVip"]}");
    print("themeIndex: ${(result[0]["themeIndex"])}");

    //print("${result[0]["totalBudget"].toString()}");
    //print(" tot bdg : ${BudgetMetaData.fromMap(result[0]).totalBudget == 0.0}");
    return BudgetMetaData.fromMap(result[0]);
  }

  //--------------------------------------------------------------------------------------------------------
  //Notifier Members
  //--------------------------------------------------------------------------------------------------------

  static List<ExpenseModel> expenseList = []; // ExpenseModel.expenseList;
  static List<String> dateList = []; //ExpenseModel.dateList;
  static late BudgetMetaData _budgetMetaData =
      BudgetMetaData.singletonBudgetMetaData;

  static double ExpenseOfTheMonth =
      0.0; //displayed on the top card of home screen
  static double IncomeOfTheMonth =
      0.0; //displayed on the top card of home screen

  //static double totalBudget = 0.0;
  static late DateTime endDate;

  //to keep track of current theme
  static ThemeManager themeManager = ThemeManager();

  late List<Map<String, dynamic>> _listOfMapOfExpenses;

  //to fill dates with list of dates
  void fetchDatesFromExpenseList() {
    expenseList.forEach((expense) {
      if (!dateList.contains(myDateFormatter(expense.date))) {
        dateList.add(myDateFormatter(expense.date));
      }
    });
  }

  // initializes the total expense and income that are displayed on the top of the screen
  initOtherMembers() {
    IncomeOfTheMonth = ExpenseOfTheMonth = 0.0;
    expenseList.forEach((expense) {
      if (expense.date.month == DateTime.now().month &&
          expense.category == "Income") IncomeOfTheMonth += expense.expense;

      if (expense.date.month == DateTime.now().month &&
          expense.category == "Expense") ExpenseOfTheMonth += expense.expense;
    });
  }

  //to change the global total expense and the income on addition and deletion in the current month
  updateMonthlyExpenseAndIncome(ExpenseModel e, int action) {
    if (action == 1) {
      if (e.date.month == DateTime.now().month && e.category == "Income") {
        print("to add $IncomeOfTheMonth");
        IncomeOfTheMonth += e.expense;
        print("to add $IncomeOfTheMonth");
        notifyListeners();
      }
      if (e.date.month == DateTime.now().month && e.category == "Expense") {
        print("to add $ExpenseOfTheMonth");
        ExpenseOfTheMonth += e.expense;
        print("to add $ExpenseOfTheMonth");
        notifyListeners();
      }
    }
    if (action == -1) {
      print("to delete");
      if (e.date.month == DateTime.now().month && e.category == "Income") {
        print("to remove $IncomeOfTheMonth");
        IncomeOfTheMonth -= e.expense;
        print("to remove $IncomeOfTheMonth");
        notifyListeners();
      }
      if (e.date.month == DateTime.now().month && e.category == "Expense") {
        print("to remove $IncomeOfTheMonth");
        ExpenseOfTheMonth -= e.expense;
        print("to remove $IncomeOfTheMonth");
        notifyListeners();
      }
    }
  }

  //add the expense to the list
  Future addExpenses(ExpenseModel expense, {bool throughUpdate = false}) async {
    if (!dateList.contains(myDateFormatter(expense.date))) {
      dateList.add(myDateFormatter(expense.date));
    }

    //updateMonthlyExpenseAndIncome(expense, 1);

    if (!throughUpdate) expense.id = DateTime.now().microsecondsSinceEpoch;
    expenseList.add(expense);

    initOtherMembers();

    notifyListeners();

    await _insertExpenseInDatabase(expense);

    return 1;
  }

  //delete expense from the list
  void deleteExpenses(ExpenseModel expense) async {
    //updateMonthlyExpenseAndIncome(expense, -1);
    expenseList.removeWhere((item) => item.id == expense.id);
    await _deleteExpenseFromDatabase(expense.id);
    initOtherMembers();
    notifyListeners();
  }

  //update expense in the list
  void updateExpenses(ExpenseModel expense) async {
    deleteExpenses(expense);
    addExpenses(expense, throughUpdate: true);
    await _updateExpenseInDatabase(expense);
  }

  //to segregate the expense list on the basis of the list
  List<ExpenseModel> Filter(String formattedDate) {
    List<ExpenseModel> listOfDate = [];
    expenseList.forEach((expense) {
      if (myDateFormatter(expense.date) == formattedDate)
        listOfDate.add(expense);
    });
    return listOfDate;
  }

  ExpenseModel? getObjectWith(int id) {
    for (var expense in expenseList) if (expense.id == id) return expense;
  }

  static BudgetMetaData getMetaData() {
    return _budgetMetaData;
  }

  updateMetaData() async {
    await _updateMetaDataDatabase();
    print("updated in db");
    notifyListeners();
  }

  Future<void> createExcelSheet(Directory directory) async {
    List<List<dynamic>> table = [];
    //Setting headers for csv
    List<dynamic> headers = [
      "Sr No.",
      "Title",
      "Expense/Income",
      "Date",
      "Category",
      "Remark"
    ];
    table.add(headers);

    _listOfMapOfExpenses = await _getExpenseMapList();

    //add elements into table from map fetched through database
    for (int i = 0; i < _listOfMapOfExpenses.length; i++) {
      List<dynamic> row = [];
      row.add(i + 1);
      row.add(_listOfMapOfExpenses[i][col_title]);
      row.add(_listOfMapOfExpenses[i][col_expense]);
      row.add(_listOfMapOfExpenses[i][col_date]);
      row.add(_listOfMapOfExpenses[i][col_category]);
      row.add(_listOfMapOfExpenses[i][col_remark]);

      table.add(row);
    }
    //store file in documents folder
    String dir = (await getExternalStorageDirectory())!.path + "/budget.csv";
    File f = new File(dir);

    // convert rows to String and write as csv file
    String csv = const ListToCsvConverter().convert(table);
    await f.writeAsString(csv);
    OpenFile.open(dir);
  }

  Future<void> createExcel(Directory directory) async {
    _listOfMapOfExpenses = await _getExpenseMapList();
    var workbook = Workbook();
    var worksheet = workbook.worksheets[0];

    worksheet.getRangeByName("A1").setText("Sr No.");
    worksheet.getRangeByName("B1").setText("Title");
    worksheet.getRangeByName("C1").setText("Expense/Income");
    worksheet.getRangeByName("D1").setText("Date");
    worksheet.getRangeByName("E1").setText("Category");
    worksheet.getRangeByName("F1").setText("Remark");

    for (int i = 2; i < _listOfMapOfExpenses.length + 2; i++) {
      worksheet.getRangeByName("A$i").setText("${i - 1}");
      worksheet
          .getRangeByName("B$i")
          .setText("${_listOfMapOfExpenses[i - 2][col_title]} ");
      worksheet
          .getRangeByName("C$i")
          .setText("${_listOfMapOfExpenses[i - 2][col_expense]} ");
      worksheet.getRangeByName("D$i").setText(
          "${myDateFormatter(DateTime.parse(_listOfMapOfExpenses[i - 2][col_date]))}");
      worksheet
          .getRangeByName("E$i")
          .setText("${_listOfMapOfExpenses[i - 2][col_category]}");
      worksheet
          .getRangeByName("F$i")
          .setText("${_listOfMapOfExpenses[i - 2][col_remark]}");
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    String filename = "${directory.path}/budget.xlsx";
    File file = File(filename);
    await file.writeAsBytes(bytes, flush: true);
    print("done");
    OpenFile.open(filename);
  }

  Future<void> changeTheme(int themeIndex) async {
    themeManager.changeTheme(themeIndex);
    print("CT : ${themeManager.currentThemeIndex}");
    _budgetMetaData.themeIndex = themeManager.currentThemeIndex;
    await updateMetaData();
    notifyListeners();
  }
}

@protected
class BudgetMetaData {
  int metaDataId = 1000;
  double totalBudget = 0.0;
  DateTime endDate = DateTime.now();
  bool isVip = false;
  int themeIndex = 0;

  BudgetMetaData._internal(); //private factory default constructor

  static BudgetMetaData singletonBudgetMetaData =
      BudgetMetaData._internal(); //singleton object copy

  factory BudgetMetaData.parameterized_BudgetMetaData(
      {required double totalBudget,
      required DateTime endDate,
      required bool isVip,
      required int themeIndex}) //parameterized factory constructor
  {
    singletonBudgetMetaData.totalBudget = totalBudget;
    singletonBudgetMetaData.endDate = endDate;
    singletonBudgetMetaData.isVip = isVip;
    singletonBudgetMetaData.themeIndex = themeIndex;

    return singletonBudgetMetaData;
  }

  factory BudgetMetaData.fromMap(Map<String, dynamic> map) {
    return BudgetMetaData.parameterized_BudgetMetaData(
        totalBudget: map["totalBudget"].toDouble(),
        endDate: DateTime.parse(map["endDate"]),
        isVip: map["isVip"] == 1 ? true : false,
        themeIndex: map["themeIndex"]);
  }

  Map<String, Object?> toMap() {
    return {
      "metaDataId": this.metaDataId,
      "totalBudget": this.totalBudget,
      "endDate": this.endDate.toString(),
      "isVip": this.isVip ? 1 : 0,
      "themeIndex": this.themeIndex
    };
  }
}
