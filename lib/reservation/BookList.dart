import 'package:flutter/material.dart';
import 'package:travelmanager/reservation/reservation.dart';
import 'package:travelmanager/reservation/reservation_dao.dart';
import '../app_database.dart';
import 'ReservationDetail.dart';

class BookList extends StatefulWidget {
  BookList({super.key});

  @override
  _BookList createState() => _BookList();
}

class _BookList extends State<BookList> {

  final List<Reservation> bookFlight = [];
  late ReservationDao myDao;

  @override
  void initState() {
    super.initState();

    $FloorAppDatabase.databaseBuilder("reservationDB").build().then((database){
      myDao = database.reservationDao;
      myDao.findAllReservations().then((ListOfReservation){
        setState(() {
          bookFlight.clear();
          bookFlight.addAll(ListOfReservation);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (bookFlight.isEmpty)
            const Text('There are no booked flight')
          else
            Expanded(
              child: ListView.builder(
                  itemCount: bookFlight.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ReservationDetail();
                      },
                      child: SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Reservation: $index'),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
        ]
    );
  }
}