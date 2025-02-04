
import 'package:expensetrackerapplication/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'data/expense_data.dart';

void main() async {
  //init hive
  await Hive.initFlutter();
  //Open a hive db
  await Hive.openBox("expense_database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=>ExpenseData(),
      builder: (context,child)=>const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
      )
      );


  }
}
