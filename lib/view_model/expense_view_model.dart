import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expense_tracker_app/data/hive_storage_repository.dart';
import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:flutter/foundation.dart';

class ExpenseViewModel with ChangeNotifier {
  HiveRepository hive = HiveRepository();
  ExpenseViewModel() {
    getExpense();
  }
   CurrencyTextInputFormatter amountFormatter = CurrencyTextInputFormatter(
    symbol: "₦",
    name: "NGN",
    locale: Platform.localeName,
    decimalDigits: 2,
  );
  List<ExpenseModel> _expenses = [];

  List<ExpenseModel> get expenses => _expenses;
  getExpense() async {
    await HiveRepository.openHives(["expenses"]);
    var data = hive.get(key: "expenses", name: "expenses") ?? [];
    _expenses = List<ExpenseModel>.from(data.map((e) => e as ExpenseModel));
    notifyListeners();
  }

  set addExpense(ExpenseModel data) {
    _expenses.add(data);
    hive.add<List<ExpenseModel>>(
        item: _expenses, key: "expenses", name: "Expenses");
    notifyListeners();
  }

  editExpense(int index, ExpenseModel data) {
    _expenses.removeAt(index);
    _expenses.insertAll(index, [data]);

    hive.add<List<ExpenseModel>>(
        item: _expenses, key: "expenses", name: "Expenses");
    notifyListeners();
  }

  set deleteExpense(int index) {
    _expenses.removeAt(index);
    hive.remove(key: "expenses", name: "Expenses");
    notifyListeners();
  }
}
