import 'package:flutter/material.dart';
import 'package:travelmanager/flights/flight.dart';
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
  final _departureCityControl = TextEditingController();
  final _destinationCityControl = TextEditingController();
  final _departureTimeControl = TextEditingController();
  final _arrivalTimeControl = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
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
        title: Text('Add Flight'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _departureCityControl,
                decoration: InputDecoration(labelText: 'Departure: City Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _destinationCityControl,
                decoration: InputDecoration(labelText: 'Destination: City Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _departureTimeControl,
                decoration: InputDecoration(labelText: 'Departure Time'),
                keyboardType: TextInputType.datetime, // Changed to datetime for better user input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter departure time';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _arrivalTimeControl,
                decoration: InputDecoration(labelText: 'Arrival Time'),
                keyboardType: TextInputType.datetime, // Changed to datetime for better user input
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
                    Flight newFlight = Flight(null,
                        _departureCityControl.text,
                        _destinationCityControl.text,
                        _departureTimeControl.text,
                        _arrivalTimeControl.text);
                    widget.onAdd(newFlight);
                    Navigator.of(context).pop();
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