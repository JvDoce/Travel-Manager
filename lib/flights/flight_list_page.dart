import 'package:flutter/material.dart';
import 'package:travelmanager/flights/flights_dao.dart';
import 'flight_detail_page.dart';
import 'flight.dart';
import 'flight_add_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// FlightListPage displays a list of flights and allows adding, updating, and deleting flights
class FlightListPage extends StatefulWidget {
  final FlightDao flightDao; // Data access object for interacting with flight database
  final SharedPreferences sharedPreferences; // SharedPreferences instance for storing preferences

  // Constructor to initialize the FlightListPage with required parameters
  const FlightListPage({
    required this.flightDao,
    required this.sharedPreferences,
    Key? key,
  }) : super(key: key);

  @override
  _FlightListPageState createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
  late Future<List<Flight>> flightFuture; // Future to hold the list of flights

  @override
  void initState() {
    super.initState();
    // Initialize flightFuture with the list of all flights
    flightFuture = widget.flightDao.getAllFlights();
  }

  // Navigate to the FlightAddPage to add a new flight
  void navigateToAddFlightPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FlightAddPage(
          onAdd: (flight) {
            _addFlight(flight); // Add the new flight to the database
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
        title: Text('Flight List'), // App bar title
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddFlightPage, // Button to navigate to add flight page
        tooltip: 'Add Flight',
        child: Icon(Icons.add), // Icon for the button
      ),
      body: FutureBuilder<List<Flight>>(
        future: flightFuture, // Future that holds the list of flights
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Error message if fetching data fails
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No flights found.')); // Message if no flights are found
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length, // Number of items in the list
              itemBuilder: (context, index) {
                Flight flight = snapshot.data![index]; // Get the flight at the current index
                return ListTile(
                  title: Text('Departure: ${flight.departureCity} Destination: ${flight.destinationCity}'),
                  subtitle: Text('Departure Time: ${flight.departureTime} Arrival Time: ${flight.arrivalTime}'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FlightDetailPage(
                          flight: flight,
                          onUpdate: onUpdateFlight, // Callback to update the flight
                          onDelete: onDeleteFlight, // Callback to delete the flight
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

  // Add a new flight to the database and update the list
  void _addFlight(Flight flight) async {
    await widget.flightDao.insertFlight(flight);
    setState(() {
      flightFuture = widget.flightDao.getAllFlights(); // Refresh the list of flights
    });
  }

  // Update an existing flight in the database and refresh the list
  void onUpdateFlight(Flight flight) async {
    await widget.flightDao.updateFlight(flight);
    setState(() {
      flightFuture = widget.flightDao.getAllFlights(); // Refresh the list of flights
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Flight updated successfully')), // Show a message upon successful update
    );
  }

  // Delete a flight from the database and refresh the list
  void onDeleteFlight(Flight flight) async {
    await widget.flightDao.deleteFlight(flight);
    setState(() {
      flightFuture = widget.flightDao.getAllFlights(); // Refresh the list of flights
    });
    Navigator.of(context).pop(); // Pop the detail page after deletion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Flight deleted successfully')), // Show a message upon successful deletion
    );
  }
}