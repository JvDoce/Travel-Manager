///Airplane Model
import 'package:floor/floor.dart';

@entity
class Airplane {
  static int ID = 1;

  @primaryKey
  final int airplane_id;
  final String type;
  final int passengers;
  final double maxSpeed;
  final double range;


  Airplane(this.airplane_id, this.type, this.passengers, this.maxSpeed, this.range){
    if (airplane_id>ID){
      ID = airplane_id;
    }
  }
}
