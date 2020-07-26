import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/event_item.dart';

import 'event_details.dart';

class WesternEvents extends StatefulWidget {
  @override
  _WesternEventsState createState() => _WesternEventsState();
}

class _WesternEventsState extends State<WesternEvents> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        // appBar: cusAppbar(
        //   context: context,
        //   title: 'ภาคตะวันตก',
        // ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('west').snapshots(),
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