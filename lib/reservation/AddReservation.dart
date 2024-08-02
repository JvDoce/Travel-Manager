import 'package:flutter/material.dart';
import 'package:travelmanager/app_database.dart';
import 'package:travelmanager/reservation/reservation.dart';
import 'package:travelmanager/reservation/reservation_dao.dart';
import '../airplane/airplane.dart';
import '../customer/customer.dart';
import '../flights/flight.dart';
import 'ReservationPage.dart';


class AddReservation extends StatefulWidget {
  final Customer selectedCustomer;
  final Flight selectedFlight;
  final Airplane selectedAirplane;
  AddReservation({required this.selectedCustomer, required this.selectedFlight, required this.selectedAirplane});

  @override
  _AddReservationState createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {
  String? resDate;

  List<Reservation> bookFlight = [];
  late ReservationDao myDao;


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

    $FloorAppDatabase.databaseBuilder("reservationDB").build().then((database){
      myDao = database.reservationDao;
      myDao.findAllReservations().then((ListOfReservation){
        setState(() {
          bookFlight.clear();
          bookFlight.addAll(ListOfReservation);
        });
      });
    });
  }

  @override
  void dispose() {
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
        _buildDetailItem('First Name: ', widget.selectedCustomer.firstName),
        _buildDetailItem('Last Name: ', widget.selectedCustomer.lastName),
        _buildDetailItem('Departure: ', widget.selectedFlight.departureCity),
        _buildDetailItem('Destination: ', widget.selectedFlight.destinationCity),
        _buildDetailItem('Airplane: ', widget.selectedAirplane.type),
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
        ElevatedButton(
          onPressed: () async {
            final newReserve = Reservation(
              Reservation.ID++,
              widget.selectedCustomer.id as int,
              widget.selectedFlight.flight_id,
              resDate!,
            );
            await myDao.insertReservation(newReserve);
            setState(() {
              bookFlight.add(newReserve);
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReservationPage()),
            );
          },
          child: const Text('Reserve a Flight'),
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

