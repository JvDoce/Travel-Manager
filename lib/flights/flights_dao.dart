import 'package:floor/floor.dart';
import 'flight.dart';

@dao
abstract class FlightDao {
  @Query('SELECT * FROM Flight')
  Future<List<Flight>> getAllFlights();

  @Query('SELECT * FROM Airplane WHERE id = :id')
  Stream<Flight?> findFlightById(int id);

  @insert
  Future<void> insertFlight(Flight flight);

  @update
  Future<void> updateFlight(Flight flight);

  @delete
  Future<void> deleteFlight(Flight flight);
}
