import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:expense_tracker_app/utils/validator.dart';
import 'package:expense_tracker_app/view_model/expense_view_model.dart';
import 'package:expense_tracker_app/views/custom_views.dart/custom_date_text_field.dart';
import 'package:expense_tracker_app/views/custom_views.dart/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class AddExpenseView extends StatefulHookWidget {
  static String id = 'add_expense';
  const AddExpenseView({super.key});

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var description = useTextEditingController();
    var category = useTextEditingController();
    var date = useTextEditingController();
    var amount = useTextEditingController();
    var expenseDate = ValueNotifier(DateTime.now());
    var viewModel = context.watch<ExpenseViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),
      body: Form(
          key: formKey,
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: Column(
              children: [
                CustomInputfield(
                  controller: amount,
                  fieldName: "Amount",
                  maxLines: 1,
                  inputType: TextInputType.number,
                  isRequiredField: true,
                  expenseField: true,
                  onValidate: Validators.validateIsEmpty,
                ),
                CustomInputfield(
                  controller: description,
                  fieldName: "Description",
                  maxLines: 1,
                  isRequiredField: false,
                  expenseField: true,
                  onValidate: Validators.validateIsEmpty,
                ),
                CustomInputfield(
                  controller: category,
                  fieldName: "Expense category",
                  maxLines: 1,
                  isRequiredField: true,
                  expenseField: true,
                  onValidate: Validators.validateIsEmpty,
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    alignment: Alignment.centerLeft,
                    child: const TextFieldHeader(
                      textHeader: "Date",
                      isRequiredField: true,
                    )),
                DateField(
                  controller: date,
                  fieldName: "Date",
                  fillField: true,
                  selectedDate: expenseDate.value,
                  isRequiredField: true,
                  hasHeaderTitle: true,
                  onValidate: Validators.validateIsEmpty,
                  onChange: (date) {
                    expenseDate.value = date;
                  },
                ),
                MaterialButton(
                    color: ColorScheme.fromSwatch(primarySwatch: Colors.green)
                        .background,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    elevation: 2,
                    child: const Text(
                      "Save Expense",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        viewModel.addExpense = ExpenseModel(
                            amount.text,
                            category.text,
                            description.text,
                            DateTime.parse(date.text));

                        Navigator.pop(context);
                        // HiveRepository()
                        //     .add(item: item, key: key, name: "Expenses");
                      }
                    })
              ],
            ),
          )),
    );
  }
}
