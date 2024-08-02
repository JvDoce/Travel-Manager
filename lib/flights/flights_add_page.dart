import 'package:flutter/material.dart';
import 'flight.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlightAddPage extends StatefulWidget {
  final Function(Flight) onAdd;
  final SharedPreferences sharedPreferences;

  const FlightAddPage({
    required this.onAdd,
    required this.sharedPreferences,
    Key? key,
  }) : super(key: key);

  @override
  _FlightAddPageState createState() => _FlightAddPageState();
}

class _FlightAddPageState extends State<FlightAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _departureCityController = TextEditingController();
  final _destinationCityController = TextEditingController();
  final _departureTimeController = TextEditingController();
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newFlight = Flight(
                      id: null, // ID will be auto-generated
                      departureCity: _departureCityController.text,
                      destinationCity: _destinationCityController.text,
                      departureTime: _departureTimeController.text,
                      arrivalTime: _arrivalTimeController.text,
                    );
                    widget.onAdd(newFlight);
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