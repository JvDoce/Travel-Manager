import 'package:flutter/material.dart';
import 'ReservationDetail.dart';

class BookList extends StatelessWidget {
  BookList({super.key});

  final List<String> bookFlight = [];

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