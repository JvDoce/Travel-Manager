import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

import 'airplane/airplane_dao.dart';
import 'airplane/airplane.dart';
import 'customer/customer_dao.dart';
import 'customer/customer.dart';
import 'flights/flights_dao.dart';
import 'flights/flight.dart';
import 'reservation/reservation_dao.dart';
import 'reservation/reservation.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Airplane, Customer, Flight, Reservation])
abstract class AppDatabase extends FloorDatabase {
  AirplaneDao get airplaneDao;
  CustomerDao get customerDao;
  FlightDao get flightDao;
  ReservationDao get reservationDao;
}