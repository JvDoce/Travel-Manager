import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'flight.dart';

// Data Access Object (DAO) for managing flight data in the SQLite database.
class FlightDao {
  // Singleton instance of [FlightDao].
  static final FlightDao instance = FlightDao._init();

  // SQLite database instance.
  static Database? _database;

  // Private constructor to ensure singleton pattern.
  FlightDao._init();

  /* Getter to initialize and get the database instance.
   *
   * If the database is already initialized, it returns the existing instance.
   * Otherwise, it initializes the database.
   */
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('flights.db');
    return _database!;
  }

  /* Initialize the database.
   * This function sets up the database with the given [filePath].
   */
  Future<Database> _initDB(String filePath) async {
    // Get the default database path for the device.
    final dbPath = await getDatabasesPath();
    // Join the default path with the file name to create the full path.
    final path = join(dbPath, filePath);

    // Open the database, creating it if it doesn't exist.
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /* Create the database schema.
   * This function defines the structure of the flights table.
   */
  Future _createDB(Database db, int version) async {
    const flightTable = '''CREATE TABLE flights (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        departureCity TEXT NOT NULL,
        destinationCity TEXT NOT NULL,
        departureTime TEXT NOT NULL,
        arrivalTime TEXT NOT NULL
      )''';
    await db.execute(flightTable);
  }

  /* Retrieve all flights from the database.
   * This function queries the flights table and returns a list of [Flight] objects.
   */
  Future<List<Flight>> getFlights() async {
    final db = await instance.database;
    // Query the flights table and convert the result to a list of Flight objects.
    final result = await db.query('flights');
    return result.map((json) => Flight.fromMap(json)).toList();
  }

  /* Insert a new flight into the database.
   * This function inserts the given [flight] into the flights table.
   */
  Future<void> insertFlight(Flight flight) async {
    final db = await instance.database;
    await db.insert('flights', flight.toMap());
  }

  /* Update an existing flight in the database.
   * This function updates the given [flight] in the flights table based on the flight's ID.
   */
  Future<void> updateFlight(Flight flight) async {
    final db = await instance.database;
    await db.update(
      'flights',
      flight.toMap(),
      where: 'id = ?',
      whereArgs: [flight.id],
    );
  }

  /* Delete a flight from the database.
   * This function deletes the flight with the given [id] from the flights table.
   */
  Future<void> deleteFlight(int id) async {
    final db = await instance.database;
    await db.delete(
      'flights',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /* Close the database connection.
   * This function closes the database connection when it's no longer needed.
   */
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}