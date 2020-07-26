import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/cus_appbar.dart';

class WesternEvents extends StatefulWidget {
  @override
  _WesternEventsState createState() => _WesternEventsState();
}

class _WesternEventsState extends State<WesternEvents> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: cusAppbar(
          context: context,
          title: 'ภาคตะวันตก',
        ),
        body: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}