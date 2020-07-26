import 'package:flutter/material.dart';

class NewEvent extends StatefulWidget {
  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFC9CCD1),
        // appBar: cusAppbar(
        //   context: context,
        //   title: 'ภาคกลาง',
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                'New Event',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
