import 'package:flutter/material.dart';
import 'package:travelmanager/customer/customer.dart';
import 'package:travelmanager/reservation/reservation.dart';
import 'package:travelmanager/reservation/reservation_dao.dart';
import '../app_database.dart';
import '../flights/flight.dart';

class ReservationDetail extends StatelessWidget {
  final Reservation reservation;
  ReservationDetail({required this.reservation});

  Future<Customer?> _getCustomer(AppDatabase database, int reservationId) async {
    final customerDao = database.customerDao;
    return customerDao.findCustomerById(reservationId);
  }

  Future<Flight?> _getFlight(AppDatabase database, int reservationId) async {
    final flightDao = database.flightDao;
    return await flightDao.findFlightById(reservationId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppDatabase>(
      future: $FloorAppDatabase.databaseBuilder('app_database.db').build(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        }

        final database = snapshot.data!;

        return FutureBuilder<List<dynamic>>(
          future: Future.wait([
            _getCustomer(database, reservation.customerId),
            _getFlight(database, reservation.flight_Id),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data available'));
            }

            final data = snapshot.data!;
            final customer = data[0] as Customer?;
            final flight = data[1] as Flight?;

            if (customer == null || flight == null) {
              return Center(child: Text('Data not found'));
            }

            return Scaffold(
              appBar: AppBar(
                title: Text('Reservation Details'),
              ),
              body: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Reservation ID: ${reservation.reservation_id}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Customer Name: ${customer.firstName} ${customer.lastName}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Departure City: ${flight.departureCity}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Destination City: ${flight.destinationCity}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Reservation Date: ${reservation.reservationDate}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
