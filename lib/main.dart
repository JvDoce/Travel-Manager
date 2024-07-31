import 'package:flutter/material.dart';
import 'app_database.dart';
import '../customer/customer_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(database: database, sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;
  final SharedPreferences sharedPreferences;

  MyApp({required this.database, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomerListPage(
        customerDao: database.customerDao,
        sharedPreferences: sharedPreferences,
      ),
    );
  }
}