import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppNoData extends StatelessWidget {
  String text = "";

  AppNoData({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _img(),
            // Text(
            //   text,
            //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            // )
          ],
        ),
      ),
    );
  }

  Image _img() {
    return Image.asset(
      "assets/images/no_data.png",
      fit: BoxFit.contain,
      width: 400,
      height: 230,
    );
  }
}
