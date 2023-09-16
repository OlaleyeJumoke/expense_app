import 'package:hive/hive.dart';

part 'expense_model.g.dart';
@HiveType(typeId: 0)
class ExpenseModel {
  ExpenseModel(this.amount, this.expenseCategory, this.expenseDescription, this.expenseDate);
  @HiveField(0)
  String amount;
  @HiveField(1)
  String expenseCategory;
  @HiveField(2)
  String expenseDescription;
  @HiveField(3)
  DateTime expenseDate;
}
