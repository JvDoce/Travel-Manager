import 'package:flutter/material.dart';
import 'airplane.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AirplaneAddPage extends StatefulWidget {
  final Function(Airplane) onAdd;
  final SharedPreferences sharedPreferences;

  const AirplaneAddPage({
    required this.onAdd,
    required this.sharedPreferences,
    Key? key,
  }) : super(key: key);

  @override
  _AirplaneAddPageState createState() => _AirplaneAddPageState();
}

class _AirplaneAddPageState extends State<AirplaneAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _passengersController = TextEditingController();
  final _maxSpeedController = TextEditingController();
  final _rangeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Airplane'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _typeController,
                  decoration: InputDecoration(labelText: 'Type'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter airplane type';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passengersController,
                  decoration: InputDecoration(labelText: 'Number of Passengers'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter number of passengers';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _maxSpeedController,
                  decoration: InputDecoration(labelText: 'Max Speed (km/h)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter max speed';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _rangeController,
                  decoration: InputDecoration(labelText: 'Range (km)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter range';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newAirplane = Airplane(
                        null, // ID will be auto-generated
                        _typeController.text,
                        int.parse(_passengersController.text),
                        double.parse(_maxSpeedController.text),
                        double.parse(_rangeController.text),
                      );
                      widget.onAdd(newAirplane);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
