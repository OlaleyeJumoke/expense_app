import 'package:expense_tracker_app/data/hive_storage_repository.dart';
import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:expense_tracker_app/view_model/expense_view_model.dart';
import 'package:expense_tracker_app/views/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});
  static String id = 'home_page';

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  List<ExpenseModel> expenses = [];

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<ExpenseViewModel>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddExpenseView.id);
        },
        tooltip: 'Add Expense',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text("Expense Tracker")),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ListView.builder(
            itemCount: viewModel.expenses.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      backgroundColor:
                          ColorScheme.fromSwatch(primarySwatch: Colors.green)
                              .background,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                      onPressed: (context) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  AddExpenseView(index: index, isEdit: true,)));
                      },
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 20),
                                height: 155,
                                child: Column(children: [
                                  const Text(
                                      "Are you sure you want to delete?"),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // color: CustomColors
                                            //     .buttonColorType1
                                            //     .withOpacity(
                                            //         0.1)
                                          ),
                                          child: const Text(
                                            "Cancel",
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          viewModel.deleteExpense = index;
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // color: CustomColors
                                            //     .buttonColorType1
                                          ),
                                          child: const Text(
                                            "Delete",
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ]),
                              ),
                            );
                          },
                        );
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                      color: ColorScheme.fromSwatch(primarySwatch: Colors.green)
                          .background
                          .withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Row(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(viewModel.expenses[index].expenseDescription),
                          Text(viewModel.expenses[index].expenseCategory),
                          Text(viewModel.expenses[index].expenseDate
                              .toString()
                              .split(" ")
                              .first),
                        ]),
                    const Spacer(),
                    Text(viewModel.expenses[index].amount.toString())
                  ]),
                ),
              );
            }),
      ),
    );
  }
}
