import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Add Expense',
        child: const Icon(Icons.add),
      ), 
      appBar: AppBar(title: const Text("Expense Tracker")), 
    );
  }
}