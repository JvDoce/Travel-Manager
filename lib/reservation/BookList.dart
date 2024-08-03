import 'package:flutter/material.dart';
import 'package:travelmanager/reservation/ReservationDetail.dart';
import 'package:travelmanager/reservation/reservation.dart';
import 'package:travelmanager/reservation/reservation_dao.dart';
import '../app_database.dart';
import 'AddReservation.dart';

class BookListPage extends StatefulWidget {

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  late AppDatabase _database;
  late ReservationDao _reservationDao;
  List<Reservation> _reservation = [];

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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              ReservationDetail(reservation: reservation,)
                          )
                      );
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
}