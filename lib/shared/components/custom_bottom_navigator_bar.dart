import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBottomNavigationBar extends StatelessWidget {
  int count = 0;
  String text = "";

  CustomBottomNavigationBar({Key? key, required this.count, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 35.0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("$text: $count", style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
