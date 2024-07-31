import 'package:floor/floor.dart';

@entity
class Reservation {
  static int ID = 1;

  @primaryKey
  final int reservation_id;
  final int customerId;
  final int flight_Id;
  final String reservationDate;

  Reservation(this.reservation_id, this.customerId, this.flight_Id, this.reservationDate) {
    if (reservation_id > ID) {
      ID = reservation_id;
    }
  }
}
