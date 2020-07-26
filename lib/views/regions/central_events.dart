import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/cus_appbar.dart';

class CentralEvents extends StatefulWidget {
  @override
  _CentralEventsState createState() => _CentralEventsState();
}

class _CentralEventsState extends State<CentralEvents> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: cusAppbar(
          context: context,
          title: 'ภาคกลาง',
        ),
        body: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}