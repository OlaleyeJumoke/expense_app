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
  const AddExpenseView({super.key, this.index, this.isEdit});
  final int? index;
  final bool? isEdit;

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> categories = [
    'Food',
    'Transportation',
    'Subcriptions',
    'Fuel',
    'Clothing',
    'Rent',
    'Miscellaneous',
    'Others'
  ];
  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<ExpenseViewModel>();
    var description = useTextEditingController(
        text: widget.index != null
            ? viewModel.expenses[widget.index!].expenseDescription
            : "");
    //var category = useTextEditingController();
    var date = useTextEditingController(
        text: widget.index != null
            ? viewModel.expenses[widget.index!].expenseDate.toString()
            : "");
    var amount = useTextEditingController(
        text: widget.index != null
            ? viewModel.expenses[widget.index!].amount
            : "");
    var expenseDate = ValueNotifier(DateTime.now());
    var selectedCategory = useState(widget.index != null
        ? viewModel.expenses[widget.index!].expenseCategory
        : "");

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.index != null ? "Edit Expense" : "Add Expense")),
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
                  // onValidate: Validators.validateIsEmpty,
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    alignment: Alignment.centerLeft,
                    child: const TextFieldHeader(
                      textHeader: "Expense category",
                      isRequiredField: true,
                    )),
                CustomDropDown(
                  isFill: true,
                  isRequiredField: true,
                  hasHeaderTitle: false,
                  fieldName: "Expense category",
                  hint: "Select Expense category",
                  items: categories
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                          ),
                        ),
                      )
                      .toList(),
                  onchanged: (val) {
                    selectedCategory.value = val.toString();
                  },
                  validator: (val) {
                    if (val == null) return "Required !!!";
                    return null;
                  },
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
                    child: Text(
                      widget.index != null ? "Edit Expense" : "Save Expense",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        var data = ExpenseModel(
                            amount.text,
                            selectedCategory.value,
                            description.text,
                            DateTime.parse(date.text));
                        if (widget.index != null) {
                          viewModel.editExpense(widget.index!, data);
                        } else {
                          viewModel.addExpense = data;
                        }

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
