import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'BookList.dart';
import 'BookButton.dart';
import 'ReservationDetail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reservation Page',
      home: ReservationPage(title: 'Reservation Home Page'),
    );
  }
}

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key, required this.title});

  final String title;

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
          title: Text(widget.title),
        ),
        body: Row(
          children: [
            Expanded(
                flex: 1,
                child: TabletView(),
            ),
            const Expanded(
              flex: 1,
              child: ReservationDetail(),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
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
