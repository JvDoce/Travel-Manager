import 'package:flutter/material.dart';
import 'package:travelmanager/flights/flight.dart';
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
  final _departureCityControl = TextEditingController();
  final _destinationCityControl = TextEditingController();
  final _departureTimeControl = TextEditingController();
  final _arrivalTimeControl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _departureCityControl.text = widget.flight.departureCity;
    _destinationCityControl.text = widget.flight.destinationCity;
    _departureTimeControl.text = widget.flight.departureTime;
    _arrivalTimeControl.text = widget.flight.arrivalTime;
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
                controller: _departureCityControl,
                decoration: InputDecoration(labelText: 'Departure: City Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter city name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _destinationCityControl,
                decoration: InputDecoration(labelText: 'Destination: City Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter city name';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final updatedFlight = Flight(
                          Flight.ID++,
                          _departureCityControl.text,
                          _destinationCityControl.text,
                          _departureTimeControl.text,
                          _arrivalTimeControl.text
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
