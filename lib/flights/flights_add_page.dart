import 'package:flutter/material.dart';
import 'flight.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A stateful widget for adding a new Flight.
class FlightAddPage extends StatefulWidget {
  // Callback function to be called when a new flight is added.
  final Function(Flight) onAdd;

  // Shared preferences instance for persistent storage.
  final SharedPreferences sharedPreferences;

  /* Constructor for [FlightAddPage].
   *
   * The [onAdd] callback and [sharedPreferences] are required.
   */
  const FlightAddPage({
    required this.onAdd,
    required this.sharedPreferences,
    Key? key,
  }) : super(key: key);

  @override
  _FlightAddPageState createState() => _FlightAddPageState();
}

// The state for [FlightAddPage].
class _FlightAddPageState extends State<FlightAddPage> {
  // Global key for the form widget.
  final _formKey = GlobalKey<FormState>();

  // Controller for the departure city text field.
  final _departureCityController = TextEditingController();

  // Controller for the destination city text field.
  final _destinationCityController = TextEditingController();

  // Controller for the departure time text field.
  final _departureTimeController = TextEditingController();

  // Controller for the arrival time text field.
  final _arrivalTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Flight'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Text field for departure city
              TextFormField(
                controller: _departureCityController,
                decoration: InputDecoration(labelText: 'Departure City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter departure city';
                  }
                  return null;
                },
              ),
              // Text field for destination city
              TextFormField(
                controller: _destinationCityController,
                decoration: InputDecoration(labelText: 'Destination City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter destination city';
                  }
                  return null;
                },
              ),
              // Text field for departure time
              TextFormField(
                controller: _departureTimeController,
                decoration: InputDecoration(labelText: 'Departure Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter departure time';
                  }
                  return null;
                },
              ),
              // Text field for arrival time
              TextFormField(
                controller: _arrivalTimeController,
                decoration: InputDecoration(labelText: 'Arrival Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter arrival time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Button to submit the form
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Create a new flight object with the form data
                    final newFlight = Flight(
                      null, // ID will be auto-generated
                      _departureCityController.text,
                      _destinationCityController.text,
                      _departureTimeController.text,
                      _arrivalTimeController.text,
                    );
                    // Call the onAdd callback with the new flight
                    widget.onAdd(newFlight);
                    // Navigate back to the previous screen
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}