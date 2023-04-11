import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFloatingActionButton extends StatelessWidget {

  final Function goTo;

  const CustomFloatingActionButton({Key? key, required this.goTo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 2,
      child: const Icon(Icons.add),
      onPressed: () => goTo()
    );
  }
}
