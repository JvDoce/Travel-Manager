import 'package:flutter/material.dart';
import 'flight.dart';
import 'flights_dao.dart';

// FlightsPage displays a list of flights and allows users to add, update, or delete them
class FlightsPage extends StatefulWidget {
  @override
  _FlightsPageState createState() => _FlightsPageState();
}

class _FlightsPageState extends State<FlightsPage> {
  // DAO instance for interacting with the flight database
  late FlightDao flightDao;
  // List to hold the flights fetched from the database
  List<Flight> _flights = [];

  @override
  void initState() {
    super.initState();
    flightDao = FlightDao.instance;
    _refreshFlights(); // Fetch flights when the page is initialized
  }

  // Refresh the list of flights from the database
  void _refreshFlights() async {
    final data = await flightDao.getFlights();
    setState(() {
      _flights = data; // Update the state with the fetched flights
    });
  }

  // Add a new flight to the database
  void _addFlight(String departure, String destination, String departureTime, String arrivalTime) async {
    await flightDao.insertFlight(Flight(
      departureCity: departure,
      destinationCity: destination,
      departureTime: departureTime,
      arrivalTime: arrivalTime,
    ));
    _refreshFlights(); // Refresh the flight list after adding
  }

  // Update an existing flight in the database
  void _updateFlight(Flight flight) async {
    await flightDao.updateFlight(flight);
    _refreshFlights(); // Refresh the flight list after updating
  }

  // Delete a flight from the database
  void _deleteFlight(int id) async {
    await flightDao.deleteFlight(id);
    _refreshFlights(); // Refresh the flight list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flights'),
        actions: [
          // Info button to show instructions on using the page
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Instructions'),
                  content: Text('This page allows you to add, view, update, and delete flights.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ListView to display the list of flights
          Expanded(
            child: ListView.builder(
              itemCount: _flights.length,
              itemBuilder: (context, index) {
                final flight = _flights[index];
                return ListTile(
                  title: Text('${flight.departureCity} to ${flight.destinationCity}'),
                  subtitle: Text('Departure: ${flight.departureTime}, Arrival: ${flight.arrivalTime}'),
                  onTap: () {
                    _showFlightDialog(flight: flight); // Show dialog for updating flight details
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteFlight(flight.id!); // Delete the flight
                    },
                  ),
                );
              },
            ),
          ),
          // Button to show dialog for adding a new flight
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text('Add Flight'),
              onPressed: () {
                _showFlightDialog(); // Show dialog for adding a new flight
              },
            ),
          ),
        ],
      ),
    );
  }

  // Show a dialog for adding or updating flight details
  void _showFlightDialog({Flight? flight}) {
    final _departureController = TextEditingController(text: flight?.departureCity);
    final _destinationController = TextEditingController(text: flight?.destinationCity);
    final _departureTimeController = TextEditingController(text: flight?.departureTime);
    final _arrivalTimeController = TextEditingController(text: flight?.arrivalTime);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(flight == null ? 'Add Flight' : 'Update Flight'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Input fields for flight details
            TextField(
              controller: _departureController,
              decoration: InputDecoration(labelText: 'Departure City'),
            ),
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(labelText: 'Destination City'),
            ),
            TextField(
              controller: _departureTimeController,
              decoration: InputDecoration(labelText: 'Departure Time'),
            ),
            TextField(
              controller: _arrivalTimeController,
              decoration: InputDecoration(labelText: 'Arrival Time'),
            ),
          ],
        ),
        actions: [
          // Cancel button to close the dialog
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          // Save button to either add or update a flight
          TextButton(
            onPressed: () {
              if (flight == null) {
                // Add new flight if no flight object is provided
                _addFlight(
                  _departureController.text,
                  _destinationController.text,
                  _departureTimeController.text,
                  _arrivalTimeController.text,
                );
              } else {
                // Update existing flight if a flight object is provided
                _updateFlight(Flight(
                  id: flight.id,
                  departureCity: _departureController.text,
                  destinationCity: _destinationController.text,
                  departureTime: _departureTimeController.text,
                  arrivalTime: _arrivalTimeController.text,
                ));
              }
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}