import 'package:flutter/material.dart';
import '../customer/customer.dart';
import 'CustomerList.dart';


class AddReservation extends StatefulWidget {

  final Customer customer;

  AddReservation({required this.customer});

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
        _buildDetailItem('First Name: ', widget.customer.firstName),
        _buildDetailItem('Last Name: ', widget.customer.lastName),
        DropdownButton<String>(
          value: resDate,
          hint: Text('Select Day'),
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


  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          Divider(color: Colors.grey[400]),
        ],
      ),
    );
  }

}

