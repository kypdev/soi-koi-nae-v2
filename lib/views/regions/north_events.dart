import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/cus_appbar.dart';

class NorthEvents extends StatefulWidget {
  @override
  _NorthEventsState createState() => _NorthEventsState();
}

class _NorthEventsState extends State<NorthEvents> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        // appBar: cusAppbar(
        //   context: context,
        //   title: 'ภาคเหนือ',
        // ),
        body: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}