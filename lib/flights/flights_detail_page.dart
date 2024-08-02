import 'package:flutter/material.dart';
import 'flight.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlightDetailPage extends StatefulWidget {
  final Flight flight;
  final Function(Flight) onUpdate;
  final Function(Flight) onDelete;
  final SharedPreferences sharedPreferences;

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
  final _formKey = GlobalKey<FormState>();
  final _departureCityController = TextEditingController();
  final _destinationCityController = TextEditingController();
  final _departureTimeController = TextEditingController();
  final _arrivalTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final updatedFlight = Flight(
                          id: widget.flight.id,
                          departureCity: _departureCityController.text,
                          destinationCity: _destinationCityController.text,
                          departureTime: _departureTimeController.text,
                          arrivalTime: _arrivalTimeController.text,
                        );
                        widget.onUpdate(updatedFlight);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Update'),
                  ),
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