import 'package:flutter/material.dart';
import 'package:travelmanager/flights/flight.dart';
import 'package:travelmanager/flights/flights_dao.dart';
import 'package:travelmanager/reservation/AddReservation.dart';
import '../app_database.dart';
import '../customer/customer.dart';
import '../customer/customer_dao.dart';

class FlightListPage extends StatefulWidget {
  final Customer selectedCustomer;

  FlightListPage({required this.selectedCustomer});

  @override
  _FlightListPageState createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
  late AppDatabase _database;
  late FlightDao _flightDao;
  List<Flight> _flight = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    var database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    setState(() {
      _database = database;
      _flightDao = _database.flightDao;
      _fetchFlight();
    });
  }

  Future<void> _fetchFlight() async {
    final customers = await _flightDao.findAllFlights();
    setState(() {
      _flight = customers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight List'),
      ),
      body: _buildCustomerList(),
    );
  }

  Widget _buildCustomerList() {
    return ListView.builder(
      itemCount: _flight.length,
      itemBuilder: (context, index) {
        final flight = _flight[index];
        return GestureDetector(
          onTap: (){
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('Notice'),
                content: Text('Confirm Selected Flight'),
                actions: <Widget>[
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddReservation(customer: widget.selectedCustomer, flight: flight)),
                        );
                      },
                      child: Text('Confirm')
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            );
          },
          child: ListTile(
            title: Text('Flight: ${index}'),
          ),
        );
      },
    );
  }
}
