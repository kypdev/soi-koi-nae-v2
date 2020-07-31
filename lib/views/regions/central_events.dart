import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/event_item.dart';
import 'event_details.dart';

class CentralEvents extends StatefulWidget {
  @override
  _CentralEventsState createState() => _CentralEventsState();
}

class _CentralEventsState extends State<CentralEvents> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFC9CCD1),
        // appBar: cusAppbar(
        //   context: context,
        //   title: 'ภาคกลาง',
        // ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('central').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error);
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('load');
                case ConnectionState.active:
                  return ListView(
                    children:
                        snapshot.data.documents.map((DocumentSnapshot docs) {
                      return InkWell(
                        onTap: () {
                          // print(docs['name']);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventDetails(
                                        title: docs['name'],
                                        img: docs['img'],
                                        content: docs['history'],
                                      )));
                        },
                        child: EventItem(
                          img: docs['img'],
                          title: docs['name'],
                          date: docs['date'],
                        ),
                      );
                    }).toList(),
                  );

                case ConnectionState.done:
                  return Text('done');
                case ConnectionState.none:
                  return Text('none');
              }
            }

            return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: snapshot.data.documents.map((DocumentSnapshot docs) {
                  return EventItem(
                    img: docs['img'],
                    title: docs['name'],
                    date: docs['date'],
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
