import 'package:flutter/material.dart';
import 'flight.dart';
import 'package:shared_preferences/shared_preferences.dart';

// FlightDetailPage allows the user to view and edit the details of a specific flight
class FlightDetailPage extends StatefulWidget {
  // The flight object that contains the details to be displayed
  final Flight flight;
  // Callback function for updating the flight details
  final Function(Flight) onUpdate;
  // Callback function for deleting the flight
  final Function(Flight) onDelete;
  // SharedPreferences instance for accessing and storing data
  final SharedPreferences sharedPreferences;

  // Constructor for initializing the FlightDetailPage with required parameters
  FlightDetailPage({
    required this.flight,
    required this.onUpdate,
    required this.onDelete,
    required this.sharedPreferences,
  });

  @override
  _FlightDetailPageState createState() => _FlightDetailPageState();
}

class _FlightDetailPageState extends State<FlightDetailPage> {
  // Key for the form used to validate user input
  final _formKey = GlobalKey<FormState>();

  // Text controllers for handling user input
  final _departureCityController = TextEditingController();
  final _destinationCityController = TextEditingController();
  final _departureTimeController = TextEditingController();
  final _arrivalTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with the current flight details
    _departureCityController.text = widget.flight.departureCity;
    _destinationCityController.text = widget.flight.destinationCity;
    _departureTimeController.text = widget.flight.departureTime;
    _arrivalTimeController.text = widget.flight.arrivalTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Input field for departure city
              TextFormField(
                controller: _departureCityController,
                decoration: InputDecoration(labelText: 'Departure City'),
                validator: (value) {
                  // Validation to ensure the input is not empty
                  if (value == null || value.isEmpty) {
                    return 'Please enter departure city';
                  }
                  return null;
                },
              ),
              // Input field for destination city
              TextFormField(
                controller: _destinationCityController,
                decoration: InputDecoration(labelText: 'Destination City'),
                validator: (value) {
                  // Validation to ensure the input is not empty
                  if (value == null || value.isEmpty) {
                    return 'Please enter destination city';
                  }
                  return null;
                },
              ),
              // Input field for departure time
              TextFormField(
                controller: _departureTimeController,
                decoration: InputDecoration(labelText: 'Departure Time'),
                validator: (value) {
                  // Validation to ensure the input is not empty
                  if (value == null || value.isEmpty) {
                    return 'Please enter departure time';
                  }
                  return null;
                },
              ),
              // Input field for arrival time
              TextFormField(
                controller: _arrivalTimeController,
                decoration: InputDecoration(labelText: 'Arrival Time'),
                validator: (value) {
                  // Validation to ensure the input is not empty
                  if (value == null || value.isEmpty) {
                    return 'Please enter arrival time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Button to update flight details
                  ElevatedButton(
                    onPressed: () {
                      // Validate form and update flight details
                      if (_formKey.currentState!.validate()) {
                        final updatedFlight = Flight(
                          widget.flight.id,
                          _departureCityController.text,
                          _destinationCityController.text,
                          _departureTimeController.text,
                          _arrivalTimeController.text,
                        );
                        widget.onUpdate(updatedFlight);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Update'),
                  ),
                  // Button to delete the flight
                  ElevatedButton(
                    onPressed: () {
                      widget.onDelete(widget.flight);
                      Navigator.of(context).pop();
                    },
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}