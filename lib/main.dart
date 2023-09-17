import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:expense_tracker_app/utils/app_routes.dart';
import 'package:expense_tracker_app/view_model/expense_view_model.dart';
import 'package:expense_tracker_app/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:provider/provider.dart';

void main() async {
  await _openHive();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExpenseViewModel>(
            create: (_) => ExpenseViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const HomePageView(),
        routes: appRoutes,
      ),
    );
  }
}

_openHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await pp.getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(ExpenseModelAdapter());
}
