import 'package:flutter/material.dart';
import 'package:travelmanager/reservation/CustomerList.dart';

class BookButton extends StatelessWidget{
  BookButton({super.key});


  @override
  Widget build(BuildContext context) {
    return Column( mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CustomerListPage()),
          );
        },
          child: const Text("Book a Flight"),
        )
      ],
    );
  }

}