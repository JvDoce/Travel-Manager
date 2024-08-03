import 'package:flutter/material.dart';
import 'package:travelmanager/airplane/airplane.dart';
import 'package:travelmanager/airplane/airplane_dao.dart';
import 'package:travelmanager/flights/flight.dart';
import 'AddReservation.dart';
import '../app_database.dart';
import '../customer/customer.dart';

class AirplaneListPage extends StatefulWidget {
  final Flight selectedFlight;
  final Customer selectedCustomer;
  AirplaneListPage({required this.selectedCustomer, required this.selectedFlight});

  @override
  _AirplaneListPageState createState() => _AirplaneListPageState();
}

class _AirplaneListPageState extends State<AirplaneListPage> {
  late AppDatabase _database;
  late AirplaneDao _airplaneDao;
  List<Airplane> _airplane = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    var database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    setState(() {
      _database = database;
      _airplaneDao = _database.airplaneDao;
      _fetchAirplane();
    });
  }

  Future<void> _fetchAirplane() async {
    final airplane = await _airplaneDao.getAllAirplanes();
    setState(() {
      _airplane = airplane;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airplane List'),
      ),
      body: _buildCustomerList(),
    );
  }

  Widget _buildCustomerList() {
    return Center(
      child: Column(
          children: <Widget>[
            if (_airplane.isEmpty)
              const Text('No Available Flight')
            else
              Expanded(child:
              ListView.builder(
                itemCount: _airplane.length,
                itemBuilder: (context, index) {
                  final airplane = _airplane[index];
                  return GestureDetector(
                    onTap: (){
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Notice'),
                          content: Text('Confirm Selected Airplane'),
                          actions: <Widget>[
                            ElevatedButton(
                                onPressed: (){
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
                      title: Text('Airplane: ${airplane.id}'),
                      subtitle: Text('${airplane.type}')
                    ),
                  );
                },
              )
              )
          ]
      ),
    );

  }
}