import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/cus_appbar.dart';

class SouthernEvents extends StatefulWidget {
  @override
  _SouthernEventsState createState() => _SouthernEventsState();
}

class _SouthernEventsState extends State<SouthernEvents> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: cusAppbar(
          context: context,
          title: 'ภาคใต้',
        ),
        body: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}