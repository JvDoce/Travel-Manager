import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'flight.dart';

class FlightDao {
  static final FlightDao instance = FlightDao._init();
  static Database? _database;

  FlightDao._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('flights.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

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

  Future<List<Flight>> getFlights() async {
    final db = await instance.database;
    final result = await db.query('flights');
    return result.map((json) => Flight.fromMap(json)).toList();
  }

  Future<void> insertFlight(Flight flight) async {
    final db = await instance.database;
    await db.insert('flights', flight.toMap());
  }

  Future<void> updateFlight(Flight flight) async {
    final db = await instance.database;
    await db.update(
      'flights',
      flight.toMap(),
      where: 'id = ?',
      whereArgs: [flight.id],
    );
  }

  Future<void> deleteFlight(int id) async {
    final db = await instance.database;
    await db.delete(
      'flights',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}