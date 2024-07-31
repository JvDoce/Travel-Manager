import 'package:flutter/material.dart';

class BookButton extends StatelessWidget{
  BookButton({super.key});


  @override
  Widget build(BuildContext context) {
    return Column( mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () {},
          child: const Text("Book a Flight"),
        )
      ],
    );
  }

}