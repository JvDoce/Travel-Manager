import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travelmanager/main.dart';
import 'package:travelmanager/reservation/reservation.dart';
import 'package:travelmanager/reservation/reservation_dao.dart';
import '../app_database.dart';
import '../customer/customer.dart';
import '../flights/flight.dart';
import 'AddReservation.dart';
import 'BookList.dart';

class ReservationPage extends StatefulWidget {
  ReservationPage({super.key,});

  @override
  State<ReservationPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ReservationPage> {
  late AppDatabase _database;
  late ReservationDao _reservationDao;
  List<Reservation> _reservation = [];

  Reservation? _selectedReservation;
  int? _selectedCustomerID;
  int? _selectedFlightID;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    var database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    setState(() {
      _database = database;
      _reservationDao = _database.reservationDao;
      _fetchReservation();
    });
  }

  Future<void> _fetchReservation() async {
    final reservation = await _reservationDao.findAllReservations();
    setState(() {
      _reservation = reservation;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    if ((width > height) && (width > 720)){
      return Scaffold(
        appBar: AppBar(
          title: const Text('Reservation Page'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()), // Replace HomePage with your actual homepage widget
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ),
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: TabletView(),
            ),
            Expanded(
              flex: 1,
              child: TabletDetail(_selectedReservation, _selectedCustomerID, _selectedFlightID), // Initialize with null for now
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Reservation Page'),
        ),
        body: MobileView(),
      );
    }
  }

  Widget TabletView(){
    return Center(
      child: Column(
          children: <Widget>[
            ElevatedButton(onPressed: () { AlignmentDirectional.center;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddReservation()),
            );
            },
              child: const Text("Book a Flight"),
            ),
            if (_reservation.isEmpty)
              const Text('No Reservation')
            else
              Expanded(child:
              ListView.builder(
                itemCount: _reservation.length,
                itemBuilder: (context, index) {
                  final reservation = _reservation[index];
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        _selectedReservation = reservation;
                        _selectedCustomerID = reservation.customerId;
                        _selectedFlightID = reservation.flight_Id;
                      });
                              // TabletDetail(reservation, reservation.customerId, reservation.flight_Id);
                    },
                    child: ListTile(
                        title: Text('Reservation: ${reservation.reservation_id}'),
                        subtitle: Text('Flight: ${reservation.flight_Id} Date: ${reservation.reservationDate}')
                    ),
                  );
                },
              )
              ),
          ]
      ),
    );
  }

  Future<Customer?> _getCustomer(AppDatabase database, int reservationId) async {
    final customerDao = database.customerDao;
    return customerDao.findCustomerById(reservationId);
  }

  Future<Flight?> _getFlight(AppDatabase database, int reservationId) async {
    final flightDao = database.flightDao;
    return await flightDao.findFlightById(reservationId);
  }

  Widget TabletDetail(Reservation? reservation, int? customerID, int? flightID){
    if (reservation == null || customerID == null || flightID == null) {
      return Center(child: Text('Select a reservation to see details.'));
    }
    return FutureBuilder<AppDatabase>(
      future: $FloorAppDatabase.databaseBuilder('app_database.db').build(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        }

        final database = snapshot.data!;

        return FutureBuilder<List<dynamic>>(
          future: Future.wait([
            _getCustomer(database, customerID),
            _getFlight(database, flightID),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data available'));
            }

            final data = snapshot.data!;
            final customer = data[0] as Customer?;
            final flight = data[1] as Flight?;

            if (customer == null || flight == null) {
              return Center(child: Text('Data not found'));
            }

            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Title(color: Colors.black, child: Text('Reservation Details',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),),
                    Text(''),
                    Text(
                      'Reservation ID: ${reservation.reservation_id}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Customer Name: ${customer.firstName} ${customer.lastName}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Departure City: ${flight.departureCity}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Destination City: ${flight.destinationCity}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Reservation Date: ${reservation.reservationDate}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
          },
        );
      },
    );
  }

  Widget MobileView(){
    return BookListPage();
  }
}
