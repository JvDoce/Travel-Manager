import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travelmanager/reservation/reservation.dart';

import '../airplane/airplane.dart';
import '../customer/customer.dart';
import '../flights/flight.dart';
import 'BookList.dart';
import 'BookButton.dart';
import 'ReservationDetail.dart';


class ReservationPage extends StatefulWidget {
  ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ReservationPage> {

  List<String> book = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    if ((width > height) && (width > 720)){
      return Scaffold(
        appBar: AppBar(
          title: const Text('Reservation Page'),
        ),
        body: Row(
          children: [
            Expanded(
                flex: 1,
                child: TabletView(),
            ),
            Expanded(
              flex: 1,
              child: ReservationDetail()
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Reservation Page'),
        ),
        body: Center(
              child: MobileView(),
        ),
      );
      }
  }

  Widget TabletView(){
    return Column( children: [
      BookButton(),
      BookList()
    ],
    );
  }

  Widget MobileView(){
    return Column( children: [
      BookButton(),
      BookList()
    ],
    );
  }

}
