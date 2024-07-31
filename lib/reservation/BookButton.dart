import 'package:flutter/material.dart';
import 'AddReservation.dart';

class BookButton extends StatelessWidget{
  BookButton({super.key});


  @override
  Widget build(BuildContext context) {
    return Column( mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddReservation()),
          );
        },
          child: const Text("Book a Flight"),
        )
      ],
    );
  }

}