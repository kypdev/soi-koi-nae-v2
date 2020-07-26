import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/cus_appbar.dart';

class EasternEvents extends StatefulWidget {
  @override
  _EasternEventsState createState() => _EasternEventsState();
}

class _EasternEventsState extends State<EasternEvents> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: cusAppbar(
          context: context,
          title: 'ภาคตะวันออก',
        ),
        body: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}