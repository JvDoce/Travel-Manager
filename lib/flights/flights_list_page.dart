import 'package:flutter/material.dart';
import 'package:travelmanager/flights/flights_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flight.dart';
import 'flights_add_page.dart';
import 'flights_detail_page.dart'; // Ensure this import is included

class FlightListPage extends StatefulWidget {
  final FlightDao flightDao;
  final SharedPreferences sharedPreferences;

  const FlightListPage({
    required this.flightDao,
    required this.sharedPreferences,
    Key? key,
  }) : super(key: key);

  @override
  _FlightListPageState createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
  late Future<List<Flight>> flightFuture;

  @override
  void initState() {
    super.initState();
    flightFuture = widget.flightDao.getAllFlights();
  }

  void navigateToAddFlightPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FlightAddPage(
          onAdd: (flight) {
            _addFlight(flight);
          },
          sharedPreferences: widget.sharedPreferences,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airplane List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddFlightPage,
        tooltip: 'Add Flight',
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Flight>>(
        future: flightFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Flight found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Flight flight = snapshot.data![index];
                return ListTile(
                  title: Text('Departure: ${flight.departureCity} Destination: ${flight.destinationCity}'),
                  subtitle: Text('Departure Time: ${flight.departureTime} Destination Time: ${flight.arrivalTime}'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FlightDetailPage(
                          flight: flight,
                          onUpdate: onUpdateFlight,
                          onDelete: onDeleteFlight,
                          sharedPreferences: widget.sharedPreferences,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void _addFlight(Flight flight) async {
    await widget.flightDao..insertFlight(flight);
    setState(() {
      flightFuture = widget.flightDao.getAllFlights();
    });
  }

  void onUpdateFlight(Flight flight) async {
    await widget.flightDao.updateFlight(flight);
    setState(() {
      flightFuture = widget.flightDao.getAllFlights();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Flight updated successfully')),
    );
  }

  void onDeleteFlight(Flight flight) async {
    await widget.flightDao.deleteFlight(flight);
    setState(() {
      flightFuture = widget.flightDao.getAllFlights();
    });
    Navigator.of(context).pop(); // Pop the detail page after deletion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Flight deleted successfully')),
    );
  }
}
