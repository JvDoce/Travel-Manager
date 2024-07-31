// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AirplaneDao? _airplaneDaoInstance;

  CustomerDao? _customerDaoInstance;

  FlightDao? _flightDaoInstance;

  ReservationDao? _reservationDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Airplane` (`airplane_id` INTEGER NOT NULL, `type` TEXT NOT NULL, `passengers` INTEGER NOT NULL, `maxSpeed` REAL NOT NULL, `range` REAL NOT NULL, PRIMARY KEY (`airplane_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Customer` (`customer_id` INTEGER NOT NULL, `firstName` TEXT NOT NULL, `lastName` TEXT NOT NULL, `address` TEXT NOT NULL, `birthday` TEXT NOT NULL, PRIMARY KEY (`customer_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Flight` (`flight_id` INTEGER NOT NULL, `departureCity` TEXT NOT NULL, `destinationCity` TEXT NOT NULL, `departureTime` TEXT NOT NULL, `arrivalTime` TEXT NOT NULL, PRIMARY KEY (`flight_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Reservation` (`reservation_id` INTEGER NOT NULL, `customerId` INTEGER NOT NULL, `flight_Id` INTEGER NOT NULL, `reservationDate` TEXT NOT NULL, PRIMARY KEY (`reservation_id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AirplaneDao get airplaneDao {
    return _airplaneDaoInstance ??= _$AirplaneDao(database, changeListener);
  }

  @override
  CustomerDao get customerDao {
    return _customerDaoInstance ??= _$CustomerDao(database, changeListener);
  }

  @override
  FlightDao get flightDao {
    return _flightDaoInstance ??= _$FlightDao(database, changeListener);
  }

  @override
  ReservationDao get reservationDao {
    return _reservationDaoInstance ??=
        _$ReservationDao(database, changeListener);
  }
}

class _$AirplaneDao extends AirplaneDao {
  _$AirplaneDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _airplaneInsertionAdapter = InsertionAdapter(
            database,
            'Airplane',
            (Airplane item) => <String, Object?>{
                  'airplane_id': item.airplane_id,
                  'type': item.type,
                  'passengers': item.passengers,
                  'maxSpeed': item.maxSpeed,
                  'range': item.range
                },
            changeListener),
        _airplaneUpdateAdapter = UpdateAdapter(
            database,
            'Airplane',
            ['airplane_id'],
            (Airplane item) => <String, Object?>{
                  'airplane_id': item.airplane_id,
                  'type': item.type,
                  'passengers': item.passengers,
                  'maxSpeed': item.maxSpeed,
                  'range': item.range
                },
            changeListener),
        _airplaneDeletionAdapter = DeletionAdapter(
            database,
            'Airplane',
            ['airplane_id'],
            (Airplane item) => <String, Object?>{
                  'airplane_id': item.airplane_id,
                  'type': item.type,
                  'passengers': item.passengers,
                  'maxSpeed': item.maxSpeed,
                  'range': item.range
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Airplane> _airplaneInsertionAdapter;

  final UpdateAdapter<Airplane> _airplaneUpdateAdapter;

  final DeletionAdapter<Airplane> _airplaneDeletionAdapter;

  @override
  Future<List<Airplane>> findAllAirplanes() async {
    return _queryAdapter.queryList('SELECT * FROM Airplane',
        mapper: (Map<String, Object?> row) => Airplane(
            row['airplane_id'] as int,
            row['type'] as String,
            row['passengers'] as int,
            row['maxSpeed'] as double,
            row['range'] as double));
  }

  @override
  Stream<Airplane?> findAirplaneById(int id) {
    return _queryAdapter.queryStream(
        'SELECT * FROM Airplane WHERE airplane_id = ?1',
        mapper: (Map<String, Object?> row) => Airplane(
            row['airplane_id'] as int,
            row['type'] as String,
            row['passengers'] as int,
            row['maxSpeed'] as double,
            row['range'] as double),
        arguments: [id],
        queryableName: 'Airplane',
        isView: false);
  }

  @override
  Future<void> insertAirplane(Airplane airplane) async {
    await _airplaneInsertionAdapter.insert(airplane, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateAirplane(Airplane airplane) async {
    await _airplaneUpdateAdapter.update(airplane, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteAirplane(Airplane airplane) async {
    await _airplaneDeletionAdapter.delete(airplane);
  }
}

class _$CustomerDao extends CustomerDao {
  _$CustomerDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _customerInsertionAdapter = InsertionAdapter(
            database,
            'Customer',
            (Customer item) => <String, Object?>{
                  'customer_id': item.customer_id,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'address': item.address,
                  'birthday': item.birthday
                },
            changeListener),
        _customerUpdateAdapter = UpdateAdapter(
            database,
            'Customer',
            ['customer_id'],
            (Customer item) => <String, Object?>{
                  'customer_id': item.customer_id,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'address': item.address,
                  'birthday': item.birthday
                },
            changeListener),
        _customerDeletionAdapter = DeletionAdapter(
            database,
            'Customer',
            ['customer_id'],
            (Customer item) => <String, Object?>{
                  'customer_id': item.customer_id,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'address': item.address,
                  'birthday': item.birthday
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Customer> _customerInsertionAdapter;

  final UpdateAdapter<Customer> _customerUpdateAdapter;

  final DeletionAdapter<Customer> _customerDeletionAdapter;

  @override
  Future<List<Customer>> findAllCustomers() async {
    return _queryAdapter.queryList('SELECT * FROM Customer',
        mapper: (Map<String, Object?> row) => Customer(
            row['customer_id'] as int,
            row['firstName'] as String,
            row['lastName'] as String,
            row['address'] as String,
            row['birthday'] as String));
  }

  @override
  Stream<Customer?> findCustomerById(int id) {
    return _queryAdapter.queryStream(
        'SELECT * FROM Customer WHERE customer_id = ?1',
        mapper: (Map<String, Object?> row) => Customer(
            row['customer_id'] as int,
            row['firstName'] as String,
            row['lastName'] as String,
            row['address'] as String,
            row['birthday'] as String),
        arguments: [id],
        queryableName: 'Customer',
        isView: false);
  }

  @override
  Future<void> insertCustomer(Customer customer) async {
    await _customerInsertionAdapter.insert(customer, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    await _customerUpdateAdapter.update(customer, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCustomer(Customer customer) async {
    await _customerDeletionAdapter.delete(customer);
  }
}

class _$FlightDao extends FlightDao {
  _$FlightDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _flightInsertionAdapter = InsertionAdapter(
            database,
            'Flight',
            (Flight item) => <String, Object?>{
                  'flight_id': item.flight_id,
                  'departureCity': item.departureCity,
                  'destinationCity': item.destinationCity,
                  'departureTime': item.departureTime,
                  'arrivalTime': item.arrivalTime
                },
            changeListener),
        _flightUpdateAdapter = UpdateAdapter(
            database,
            'Flight',
            ['flight_id'],
            (Flight item) => <String, Object?>{
                  'flight_id': item.flight_id,
                  'departureCity': item.departureCity,
                  'destinationCity': item.destinationCity,
                  'departureTime': item.departureTime,
                  'arrivalTime': item.arrivalTime
                },
            changeListener),
        _flightDeletionAdapter = DeletionAdapter(
            database,
            'Flight',
            ['flight_id'],
            (Flight item) => <String, Object?>{
                  'flight_id': item.flight_id,
                  'departureCity': item.departureCity,
                  'destinationCity': item.destinationCity,
                  'departureTime': item.departureTime,
                  'arrivalTime': item.arrivalTime
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Flight> _flightInsertionAdapter;

  final UpdateAdapter<Flight> _flightUpdateAdapter;

  final DeletionAdapter<Flight> _flightDeletionAdapter;

  @override
  Future<List<Flight>> findAllFlights() async {
    return _queryAdapter.queryList('SELECT * FROM Flight',
        mapper: (Map<String, Object?> row) => Flight(
            row['flight_id'] as int,
            row['departureCity'] as String,
            row['destinationCity'] as String,
            row['departureTime'] as String,
            row['arrivalTime'] as String));
  }

  @override
  Stream<Flight?> findFlightById(int id) {
    return _queryAdapter.queryStream(
        'SELECT * FROM Flight WHERE flight_id = ?1',
        mapper: (Map<String, Object?> row) => Flight(
            row['flight_id'] as int,
            row['departureCity'] as String,
            row['destinationCity'] as String,
            row['departureTime'] as String,
            row['arrivalTime'] as String),
        arguments: [id],
        queryableName: 'Flight',
        isView: false);
  }

  @override
  Future<void> insertFlight(Flight flight) async {
    await _flightInsertionAdapter.insert(flight, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateFlight(Flight flight) async {
    await _flightUpdateAdapter.update(flight, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFlight(Flight flight) async {
    await _flightDeletionAdapter.delete(flight);
  }
}

class _$ReservationDao extends ReservationDao {
  _$ReservationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _reservationInsertionAdapter = InsertionAdapter(
            database,
            'Reservation',
            (Reservation item) => <String, Object?>{
                  'reservation_id': item.reservation_id,
                  'customerId': item.customerId,
                  'flight_Id': item.flight_Id,
                  'reservationDate': item.reservationDate
                },
            changeListener),
        _reservationUpdateAdapter = UpdateAdapter(
            database,
            'Reservation',
            ['reservation_id'],
            (Reservation item) => <String, Object?>{
                  'reservation_id': item.reservation_id,
                  'customerId': item.customerId,
                  'flight_Id': item.flight_Id,
                  'reservationDate': item.reservationDate
                },
            changeListener),
        _reservationDeletionAdapter = DeletionAdapter(
            database,
            'Reservation',
            ['reservation_id'],
            (Reservation item) => <String, Object?>{
                  'reservation_id': item.reservation_id,
                  'customerId': item.customerId,
                  'flight_Id': item.flight_Id,
                  'reservationDate': item.reservationDate
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Reservation> _reservationInsertionAdapter;

  final UpdateAdapter<Reservation> _reservationUpdateAdapter;

  final DeletionAdapter<Reservation> _reservationDeletionAdapter;

  @override
  Future<List<Reservation>> findAllReservations() async {
    return _queryAdapter.queryList('SELECT * FROM Reservation',
        mapper: (Map<String, Object?> row) => Reservation(
            row['reservation_id'] as int,
            row['customerId'] as int,
            row['flight_Id'] as int,
            row['reservationDate'] as String));
  }

  @override
  Stream<Reservation?> findReservationById(int id) {
    return _queryAdapter.queryStream(
        'SELECT * FROM Reservation WHERE reservation_id = ?1',
        mapper: (Map<String, Object?> row) => Reservation(
            row['reservation_id'] as int,
            row['customerId'] as int,
            row['flight_Id'] as int,
            row['reservationDate'] as String),
        arguments: [id],
        queryableName: 'Reservation',
        isView: false);
  }

  @override
  Future<void> insertReservation(Reservation reservation) async {
    await _reservationInsertionAdapter.insert(
        reservation, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateReservation(Reservation reservation) async {
    await _reservationUpdateAdapter.update(
        reservation, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteReservation(Reservation reservation) async {
    await _reservationDeletionAdapter.delete(reservation);
  }
}
