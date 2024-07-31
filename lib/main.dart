import 'package:flutter/material.dart';
import 'package:travelmanager/reservation/ReservationPage.dart';
import 'airplane/airplane_dao.dart';
import 'airplane/airplane_list_page.dart';
import 'customer/customer_list_page.dart'; // Adjust the import based on your project structure
//import '../airplane/airplane_list_page.dart'; // Adjust the import based on your project structure
//import '../flight/flight_list_page.dart'; // Adjust the import based on your project structure
//import '../reservation/reservation_list_page.dart'; // Adjust the import based on your project structure
import 'app_database.dart'; // Adjust the import based on your project structure
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(database, sharedPreferences));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;
  final SharedPreferences sharedPreferences;

  MyApp(this.database, this.sharedPreferences);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi-List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/customerList': (context) => CustomerListPage(
          customerDao: database.customerDao,
          sharedPreferences: sharedPreferences,
        ),
        '/airplaneList': (context) => AirplaneListPage(
          airplaneDao: database.airplaneDao,  // Ensure you have airplaneDao in your AppDatabase
          sharedPreferences: sharedPreferences,
        ),
 //       '/flightList': (context) => FlightListPage(
 //         flightDao: database.flightDao, // Ensure you have flightDao in your AppDatabase
//          sharedPreferences: sharedPreferences,
 //       ),
//        '/reservationList': (context) => ReservationListPage(
 //         sharedPreferences: sharedPreferences,
 //       ),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/customerList');
              },
              child: Text('Go to Customer List'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/airplaneList');
              },
              child: Text('Go to Airplane List'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/flightList');
              },
              child: Text('Go to Flight List'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReservationPage()),
                );
              },
              child: Text('Go to Reservations'),
            ),
          ],
        ),
      ),
    );
  }
}