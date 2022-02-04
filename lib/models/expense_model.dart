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
}

class ExpenseModel {
  final int id;
  final String title;
  final String icon;
  final double expense;
  final DateTime date;
  final String category;
  String? remark;

  ExpenseModel(
      {required this.id,
      required this.title,
      required this.icon,
      required this.expense,
      required this.date,
      required this.category,
      this.remark});

  static Map<DateTime, List<ExpenseModel>> expenseMap = {
    DateTime(2022, 1, 30): [
      ExpenseModel(
          id: 1,
          title: "Food",
          icon: AppIcons.food,
          expense: 500,
          date: DateTime(2022, 1, 30),
          category: "Expenses"),
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
    DateTime(2022, 1, 31): [
      ExpenseModel(
          id: 1,
          title: "Food",
          icon: AppIcons.food,
          expense: 500,
          date: DateTime(2022, 1, 30),
          category: "Expenses"),
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
    DateTime(2022, 2, 1): [
      ExpenseModel(
          id: 3,
          title: "Health",
          icon: AppIcons.health,
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
      ExpenseModel(
          id: 3,
          title: "Health",
          icon: AppIcons.health,
          expense: 500,
          date: DateTime(2022, 1, 30),
          category: "Expenses"),
    ],
    DateTime(2022, 2, 2): [
      ExpenseModel(
          id: 3,
          title: "Health",
          icon: AppIcons.health,
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
      ExpenseModel(
          id: 3,
          title: "Health",
          icon: AppIcons.health,
          expense: 500,
          date: DateTime(2022, 1, 30),
          category: "Expenses"),
    ]
  };
  static List<DateTime> dateList = [
    DateTime(2022, 1, 30),
    DateTime(2022, 1, 31),
    DateTime(2022, 2, 1),
    DateTime(2022, 2, 2)
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
  static List<String> IncomeCategoryList = [];

  void addToExpenses(ExpenseModel expenseModel) {
    if (expenseMap[expenseModel.date] != null)
      expenseMap[expenseModel.date]!.add(expenseModel);
    else {
      dateList.add(expenseModel.date);
      expenseMap[expenseModel.date] = [expenseModel];
    }
  }

  void removeFromExpenses(int id) {
    for (int i = 0; i < expenseMap[dateList[i]]!.length; i++)
      for (int j = 0; j < expenseMap[dateList[i]]!.length; j++) {
        if (expenseMap[dateList[i]]![j].id == id)
          expenseMap[dateList[i]]!.removeAt(j);
        if (expenseMap[dateList[i]]!.isEmpty) dateList.removeAt(i);
      }
  }

  void updateExpense(ExpenseModel Old, ExpenseModel New) {
    if (Old.date == New.date) {
    } else {}
  }
}
