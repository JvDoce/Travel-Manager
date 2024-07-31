import 'package:floor/floor.dart';

@Entity(tableName: 'Airplane')
class Airplane {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String type;
  final int passengers;
  final double maxSpeed;
  final double range;

  Airplane(this.id, this.type, this.passengers, this.maxSpeed, this.range);

  factory Airplane.fromMap(Map<String, dynamic> map) {
    return Airplane(
      map['id'],
      map['type'],
      map['passengers'],
      map['maxSpeed'], // Corrected from 'masSpeed' to 'maxSpeed'
      map['range'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'passengers': passengers,
      'maxSpeed': maxSpeed,
      'range': range,
    };
  }
}
