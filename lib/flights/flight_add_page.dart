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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                    final newAirplane = Flight(
                      Flight.ID++, // ID will be auto-generated
                      _departureCityControl.text,
                      _destinationCityControl.text,
                        _departureTimeControl.text,
                        _departureTimeControl.text
                    );
                    widget.onAdd(newAirplane);
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
