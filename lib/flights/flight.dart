///Flight model
import 'package:floor/floor.dart';

@entity
class Flight {
  static int ID = 1;

  @primaryKey
  final int flight_id;
  final String departureCity;
  final String destinationCity;
  final String departureTime;
  final String arrivalTime;

  Flight(this.flight_id, this.departureCity, this.destinationCity, this.departureTime, this.arrivalTime) {
    if (flight_id > ID) {
      ID = flight_id;
    }
  }
}