import 'package:floor/floor.dart';
import 'flight.dart';

// Data Access Object (DAO) for handling flight-related database operations
@dao
abstract class FlightDao {

  /* Retrieves all flights from the database
   * @return A [Future] that completes with a list of all [Flight] objects
   */
  @Query('SELECT * FROM flights')
  Future<List<Flight>> getAllFlights();

  /* Finds a flight by its ID
   * @param id The ID of the flight to find
   * @return A [Future] that completes with the [Flight] object if found, otherwise null
   */
  @Query('SELECT * FROM flights WHERE id = :id')
  Future<Flight?> findFlightById(int id);

  /* Inserts a new flight into the database
   * @param flight The [Flight] object to insert
   * @return A [Future] that completes when the insert operation is done
   */
  @insert
  Future<void> insertFlight(Flight flight);

  /* Updates an existing flight in the database
   * @param flight The [Flight] object with updated values
   * @return A [Future] that completes when the update operation is done
   */
  @update
  Future<void> updateFlight(Flight flight);

  /*Deletes a flight from the database
   * @param flight The [Flight] object to delete
   * @return A [Future] that completes when the delete operation is done
   */
  @delete
  Future<void> deleteFlight(Flight flight);
}