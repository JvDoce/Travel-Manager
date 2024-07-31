import 'package:flutter/material.dart';


class AddReservation extends StatefulWidget {
  @override
  _AddReservationState createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {
  late TextEditingController customerId;
  late TextEditingController flightId;
  String? resDate;

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    customerId = TextEditingController();
    flightId = TextEditingController();
  }

  @override
  void dispose() {
    customerId.dispose();
    flightId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reservation'),
      ),
      body: Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: customerId,
          decoration: InputDecoration(labelText: 'Customer Name'),
        ),
        TextField(
          controller: flightId,
          decoration: InputDecoration(labelText: 'Flight Number'),
        ),
        DropdownButton<String>(
          value: resDate,
          hint: Text('Select Reservation Day'),
          items: days.map((String day) {
            return DropdownMenuItem<String>(
              value: day,
              child: Text(day),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              resDate = newValue;
            });
          },
        ),
      ],
    )
      )
    );
  }


}

