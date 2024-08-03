import 'package:flutter/material.dart';
import 'package:travelmanager/flights/flight.dart';
import 'package:shared_preferences/shared_preferences.dart';

// StatefulWidget for adding a flight
class FlightAddPage extends StatefulWidget {
  // Callback function to handle the addition of a new flight
  final Function(Flight) onAdd;

  // SharedPreferences instance for storing preferences
  final SharedPreferences sharedPreferences;

  // Constructor to initialize the FlightAddPage with required parameters
  const FlightAddPage({
    required this.onAdd,
    required this.sharedPreferences,
    Key? key,
  }) : super(key: key);

  @override
  _FlightAddPageState createState() => _FlightAddPageState();
}

class _FlightAddPageState extends State<FlightAddPage> {
  // GlobalKey for form validation
  final _formKey = GlobalKey<FormState>();

  // TextEditingControllers to handle form input fields
  final _departureCityControl = TextEditingController();
  final _destinationCityControl = TextEditingController();
  final _departureTimeControl = TextEditingController();
  final _arrivalTimeControl = TextEditingController();

  // Dispose controllers to avoid memory leaks
  @override
  void dispose() {
    _departureCityControl.dispose();
    _destinationCityControl.dispose();
    _departureTimeControl.dispose();
    _arrivalTimeControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Flight'), // App bar title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the form
        child: Form(
          key: _formKey, // Assign form key to the form
          child: Column(
            children: [
              // TextFormField for departure city input
              TextFormField(
                controller: _departureCityControl,
                decoration: InputDecoration(labelText: 'Departure: City Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city name'; // Validation message
                  }
                  return null;
                },
              ),
              // TextFormField for destination city input
              TextFormField(
                controller: _destinationCityControl,
                decoration: InputDecoration(labelText: 'Destination: City Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city name'; // Validation message
                  }
                  return null;
                },
              ),
              // TextFormField for departure time input
              TextFormField(
                controller: _departureTimeControl,
                decoration: InputDecoration(labelText: 'Departure Time'),
                keyboardType: TextInputType.datetime, // Changed to datetime for better user input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter departure time'; // Validation message
                  }
                  return null;
                },
              ),
              // TextFormField for arrival time input
              TextFormField(
                controller: _arrivalTimeControl,
                decoration: InputDecoration(labelText: 'Arrival Time'),
                keyboardType: TextInputType.datetime, // Changed to datetime for better user input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter arrival time'; // Validation message
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Spacing between form fields and button
              // Submit button
              ElevatedButton(
                onPressed: () {
                  // Validate form inputs
                  if (_formKey.currentState!.validate()) {
                    // Create a new Flight object with form inputs
                    final newFlight = Flight(
                      id: null, // Assuming ID will be auto-generated
                      departureCity: _departureCityControl.text,
                      destinationCity: _destinationCityControl.text,
                      departureTime: _departureTimeControl.text,
                      arrivalTime: _arrivalTimeControl.text,
                    );
                    widget.onAdd(newFlight); // Call onAdd callback with the new Flight object
                    Navigator.of(context).pop(); // Navigate back to the previous screen
                  }
                },
                child: Text('Submit'), // Button label
              ),
            ],
          ),
        ),
      ),
    );
  }
}