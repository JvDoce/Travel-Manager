import 'package:flutter/material.dart';
import 'flight.dart';
import 'package:shared_preferences/shared_preferences.dart';

// FlightDetailPage allows the user to view and edit the details of a specific flight
class FlightDetailPage extends StatefulWidget {
  final Flight flight; // The flight object whose details are to be viewed or edited
  final Function(Flight) onUpdate; // Callback function for updating the flight
  final Function(Flight) onDelete; // Callback function for deleting the flight
  final SharedPreferences sharedPreferences; // SharedPreferences instance for storing preferences

  // Constructor to initialize the FlightDetailPage with required parameters
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
  final _formKey = GlobalKey<FormState>(); // GlobalKey for form validation

  // Define text controllers for handling user input
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
  void dispose() {
    // Dispose of controllers when the widget is removed from the widget tree
    _departureCityController.dispose();
    _destinationCityController.dispose();
    _departureTimeController.dispose();
    _arrivalTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Details'), // App bar title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the form
        child: Form(
          key: _formKey, // Assign form key to the form
          child: Column(
            children: [
              // Input field for departure city
              TextFormField(
                controller: _departureCityController,
                decoration: InputDecoration(labelText: 'Departure City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter departure city'; // Validation message
                  }
                  return null;
                },
              ),
              // Input field for destination city
              TextFormField(
                controller: _destinationCityController,
                decoration: InputDecoration(labelText: 'Destination City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter destination city'; // Validation message
                  }
                  return null;
                },
              ),
              // Input field for departure time
              TextFormField(
                controller: _departureTimeController,
                decoration: InputDecoration(labelText: 'Departure Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter departure time'; // Validation message
                  }
                  return null;
                },
              ),
              // Input field for arrival time
              TextFormField(
                controller: _arrivalTimeController,
                decoration: InputDecoration(labelText: 'Arrival Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter arrival time'; // Validation message
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Spacing between form fields and buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Button to update flight details
                  ElevatedButton(
                    onPressed: () {
                      // Validate form inputs
                      if (_formKey.currentState!.validate()) {
                        // Create an updated Flight object with form inputs
                        final updatedFlight = Flight(
                          id: widget.flight.id,
                          departureCity: _departureCityController.text,
                          destinationCity: _destinationCityController.text,
                          departureTime: _departureTimeController.text,
                          arrivalTime: _arrivalTimeController.text,
                        );
                        widget.onUpdate(updatedFlight); // Call onUpdate callback with the updated Flight object
                        Navigator.of(context).pop(); // Navigate back to the previous screen
                      }
                    },
                    child: Text('Update'), // Button label
                  ),
                  // Button to delete the flight
                  ElevatedButton(
                    onPressed: () {
                      widget.onDelete(widget.flight); // Call onDelete callback with the current Flight object
                      Navigator.of(context).pop(); // Navigate back to the previous screen
                    },
                    child: Text('Delete'), // Button label
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