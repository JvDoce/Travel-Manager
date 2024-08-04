import 'package:floor/floor.dart';

@Entity(tableName: 'Flight')
class Flight {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String departureCity;
  final String destinationCity;
  final String departureTime;
  final String arrivalTime;

  Flight(this.id, this.departureCity, this.destinationCity, this.departureTime, this.arrivalTime);

  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(
      map['id'],
      map['departureCity'],
      map['destinationCity'],
      map['departureTime'],
      map['arrivalTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'departureCity': departureCity,
      'destinationCity': destinationCity,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
    };
  }
}