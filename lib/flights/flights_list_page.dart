import 'package:flutter/material.dart';
import 'flight.dart';
import 'flights_dao.dart';

class FlightsPage extends StatefulWidget {
  @override
  _FlightsPageState createState() => _FlightsPageState();
}

class _FlightsPageState extends State<FlightsPage> {
  late FlightDao flightDao;
  List<Flight> _flights = [];

  @override
  void initState() {
    super.initState();
    flightDao = FlightDao.instance;
    _refreshFlights();
  }

  void _refreshFlights() async {
    final data = await flightDao.getFlights();
    setState(() {
      _flights = data;
    });
  }

  void _addFlight(String departure, String destination, String departureTime, String arrivalTime) async {
    await flightDao.insertFlight(Flight(
      departureCity: departure,
      destinationCity: destination,
      departureTime: departureTime,
      arrivalTime: arrivalTime,
    ));
    _refreshFlights();
  }

  void _updateFlight(Flight flight) async {
    await flightDao.updateFlight(flight);
    _refreshFlights();
  }

  void _deleteFlight(int id) async {
    await flightDao.deleteFlight(id);
    _refreshFlights();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flights'),
        actions: [
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
          Expanded(
            child: ListView.builder(
              itemCount: _flights.length,
              itemBuilder: (context, index) {
                final flight = _flights[index];
                return ListTile(
                  title: Text('${flight.departureCity} to ${flight.destinationCity}'),
                  subtitle: Text('Departure: ${flight.departureTime}, Arrival: ${flight.arrivalTime}'),
                  onTap: () {
                    _showFlightDialog(flight: flight);
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteFlight(flight.id!);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text('Add Flight'),
              onPressed: () {
                _showFlightDialog();
              },
            ),
          ),
        ],
      ),
    );
  }

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
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (flight == null) {
                _addFlight(
                  _departureController.text,
                  _destinationController.text,
                  _departureTimeController.text,
                  _arrivalTimeController.text,
                );
              } else {
                _updateFlight(Flight(
                  id: flight.id,
                  departureCity: _departureController.text,
                  destinationCity: _destinationController.text,
                  departureTime: _departureTimeController.text,
                  arrivalTime: _arrivalTimeController.text,
                ));
              }
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}