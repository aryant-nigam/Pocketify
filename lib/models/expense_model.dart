import 'package:intl/intl.dart';

class AppIcons {
  static const String baby = "assets/icons/baby.png";
  static const String beauty = "assets/icons/beauty.png";
  static const String bills = "assets/icons/bills.png";
  static const String book = "assets/icons/book.png";
  static const String car = "assets/icons/car.png";
  static const String clothing = "assets/icons/clothing.png";
  static const String education = "assets/icons/education.png";
  static const String electronics = "assets/icons/electronics.png";
  static const String entertainment = "assets/icons/entertainment.png";
  static const String food = "assets/icons/food.png";
  static const String fruits = "assets/icons/fruits.png";
  static const String gift = "assets/icons/gift.png";
  static const String health = "assets/icons/health.png";
  static const String home = "assets/icons/home.png";
  static const String maintenance = "assets/icons/maintenance.png";
  static const String office = "assets/icons/office.png";
  static const String others = "assets/icons/others.png";
  static const String pets = "assets/icons/pets.png";
  static const String shopping = "assets/icons/shopping.png";
  static const String snacks = "assets/icons/snacks.png";
  static const String social = "assets/icons/social.png";
  static const String sports = "assets/icons/sports.png";
  static const String tax = "assets/icons/tax.png";
  static const String telephone = "assets/icons/telephone.png";
  static const String transportation = "assets/icons/transportation.png";
  static const String travel = "assets/icons/travel.png";
  static const String vegetables = "assets/icons/vegetables.png";
  static const String Wine = "assets/icons/vines.png";
  static const String block_ads = "assets/icons/block_ads.png";
  static const String xls = "assets/icons/xls.png";
  static const String vip = "assets/icons/vip.png";
}

class ExpenseModel {
  int id;
  String title;
  String icon;
  double expense;
  DateTime date;
  String category;
  String? remark;

  static String myDateFormatter(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  ExpenseModel(
      {required this.id,
      required this.title,
      required this.icon,
      required this.expense,
      required this.date,
      required this.category,
      this.remark});

  static Map<String, List<ExpenseModel>> expenseMap = {
    "Jan 30, 2022": [
      ExpenseModel(
          id: 1,
          title: "Food",
          icon: AppIcons.food,
          expense: 500,
          date: DateTime(2022, 1, 30),
          category: "Expenses",
          remark: "At Ajay Rai's clinic"),
      ExpenseModel(
          id: 2,
          title: "Entertainment",
          icon: AppIcons.entertainment,
          expense: 500,
          date: DateTime(2022, 1, 30),
          category: "Expenses"),
      ExpenseModel(
          id: 3,
          title: "Health",
          icon: AppIcons.health,
          expense: 500,
          date: DateTime(2022, 1, 30),
          category: "Expenses"),
    ],
    "Jan 31, 2022": [
      ExpenseModel(
          id: 1,
          title: "Food",
          icon: AppIcons.food,
          expense: 500,
          date: DateTime(2022, 1, 31),
          category: "Expenses"),
      ExpenseModel(
          id: 2,
          title: "Entertainment",
          icon: AppIcons.entertainment,
          expense: 500,
          date: DateTime(2022, 1, 31),
          category: "Expenses"),
      ExpenseModel(
          id: 3,
          title: "Health",
          icon: AppIcons.health,
          expense: 500,
          date: DateTime(2022, 1, 31),
          category: "Expenses"),
    ],
    "Feb 1, 2022": [
      ExpenseModel(
          id: 3,
          title: "Health",
          icon: AppIcons.health,
          expense: 500,
          date: DateTime(2022, 2, 1),
          category: "Expenses"),
      ExpenseModel(
          id: 3,
          title: "Health",
          icon: AppIcons.health,
          expense: 500,
          date: DateTime(2022, 2, 1),
          category: "Expenses"),
      ExpenseModel(
          id: 3,
          title: "Health",
          icon: AppIcons.health,
          expense: 500,
          date: DateTime(2022, 2, 1),
          category: "Expenses"),
    ],
    "Feb 2, 2022": [
      ExpenseModel(
          id: 3,
          title: "Health",
          icon: AppIcons.health,
          expense: 500,
          date: DateTime(2022, 2, 2),
          category: "Expenses"),
      ExpenseModel(
          id: 3,
          title: "Health",
          icon: AppIcons.health,
          expense: 500,
          date: DateTime(2022, 2, 2),
          category: "Expenses"),
      ExpenseModel(
          id: 3,
          title: "Health",
          icon: AppIcons.health,
          expense: 500,
          date: DateTime(2022, 2, 2),
          category: "Expenses"),
    ]
  };

  static List<String> dateList = [
    "Jan 30, 2022",
    "Jan 31, 2022",
    "Feb 1, 2022",
    "Feb 2, 2022"
  ];
  static List<String> ExpenseCategoryList = [
    "Baby",
    "Beauty",
    "Bills",
    "Book",
    "Car",
    "Clothing",
    "Education",
    "Electronics",
    "Entertainment",
    "Food",
    "Fruits",
    "Gift",
    "Health",
    "Home",
    "Maintenance",
    "Office",
    "Others",
    "Pets",
    "Shopping",
    "Snacks",
    "Social",
    "Sports",
    "Tax",
    "Telephone",
    "Transportation",
    "Travel",
    "Vegetables",
    "Wine",
  ];

  @override
  bool operator ==(Object other) {
    if (other is ExpenseModel &&
        this.id == other.id &&
        this.icon == other.icon &&
        this.expense == other.expense &&
        this.remark == other.remark &&
        this.date == other.date &&
        this.category == other.category &&
        this.title == other.title)
      return true;
    else
      return false;
  }

  static List<String> IncomeCategoryList = [];

  static void addToExpenses(ExpenseModel expenseModel) {
    if (expenseMap[myDateFormatter(expenseModel.date)] != null)
      expenseMap[myDateFormatter(expenseModel.date)]!.add(expenseModel);
    else {
      expenseMap.addAll({
        myDateFormatter(expenseModel.date): [expenseModel]
      });
    }
  }

  /*void removeFromExpenses(int id) {
    for (int i = 0; i < expenseMap[dateList[i]]!.length; i++)
      for (int j = 0; j < expenseMap[dateList[i]]!.length; j++) {
        if (expenseMap[dateList[i]]![j].id == id)
          expenseMap[dateList[i]]!.removeAt(j);
        if (expenseMap[dateList[i]]!.isEmpty) dateList.removeAt(i);
      }
  }*/

  static void updateExpense(ExpenseModel newExpense, ExpenseModel oldExpense) {
    if (myDateFormatter(newExpense.date) != myDateFormatter(oldExpense.date))
      findAndUpdate(expenseMap[myDateFormatter(newExpense.date)], newExpense);
    else
      findAndReplace(
          expenseMap[myDateFormatter(newExpense.date)], newExpense, oldExpense);
  }

  static void findAndUpdate(
      List<ExpenseModel>? expenseListOfDate, ExpenseModel newExpense) {
    if (expenseListOfDate == null) {
      expenseMap.addAll({
        myDateFormatter(newExpense.date): [newExpense]
      });
    } else if (expenseListOfDate.length == 0) {
      expenseMap[myDateFormatter(newExpense.date)]!.add(newExpense);
    } else {
      for (int i = 0; i < expenseListOfDate.length; i++)
        if (expenseListOfDate[i] == newExpense)
          expenseMap[myDateFormatter(newExpense.date)]![i] = newExpense;
    }
  }

  static void findAndReplace(List<ExpenseModel>? expenseListOfDate,
      ExpenseModel newExpense, ExpenseModel oldExpense) {
    addToExpenses(newExpense);
    removeExpense(oldExpense);
  }

  static void removeExpense(ExpenseModel oldExpense) {
    for (int i = 0;
        i < expenseMap[myDateFormatter(oldExpense.date)]!.length;
        i++)
      if (expenseMap[myDateFormatter(oldExpense.date)]![i] == oldExpense)
        expenseMap[myDateFormatter(oldExpense.date)]!.removeAt(i);
  }
}
