import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/global.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:soi_koi_nae_v2/views/regions/central_events.dart';
import 'package:soi_koi_nae_v2/views/regions/eastern_events.dart';
import 'package:soi_koi_nae_v2/views/regions/north_events.dart';
import 'package:soi_koi_nae_v2/views/regions/northeast_events.dart';
import 'package:soi_koi_nae_v2/views/regions/southern_events.dart';
import 'package:soi_koi_nae_v2/views/regions/western_events.dart';

import 'new_event.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  // final List<Tab> tabs = <Tab>[
  //   new Tab(text: "มกราคม"),
  //   new Tab(text: "กุมภาพันธ์"),
  //   new Tab(text: "มีนาคม"),
  //   new Tab(text: "เมษายน"),
  //   new Tab(text: "พฤษภาคม"),
  //   new Tab(text: "มิถุนายน"),
  //   new Tab(text: "กรกฎาคม"),
  //   new Tab(text: "สิงหาคม"),
  //   new Tab(text: "กันยายน"),
  //   new Tab(text: "ตุลาคม"),
  //   new Tab(text: "พฤศจิกายน"),
  //   new Tab(text: "ธันวาคม"),
  // ];

  final List<Tab> tabs = <Tab>[
    new Tab(text: "งานที่ใกล้ถึง"),
    new Tab(text: "ภาคเหนือ"),
    new Tab(text: "ภาคใต้"),
    new Tab(text: "ภาคกลาง"),
    new Tab(text: "ภาคตะวันออก"),
    new Tab(text: "ภาคตะวันตก"),
    new Tab(text: "ภาคอีสาน")
  ];

  TabController _tabController;

  showProfile() {
    Navigator.pushNamed(context, '/profile');
  }

  String userID;
  inputData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    print(uid);
    setState(() {
      userID = uid.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
    inputData();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: grey,
        appBar: new AppBar(
          backgroundColor: Color(0XFFF2F3F8),
          title: InkWell(
            onTap: () => showProfile(),
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .document(userID)
                  .snapshots(),
              builder: (context, sn) {
                if (!sn.hasData) {
                  return Text('');
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(),
                    CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 23.0,
                        child: CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Color(0XFFFFFFFF),
                          backgroundImage:
                              NetworkImage(sn.data['imgpro']),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          elevation: 0,
          bottom: new TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: new BubbleTabIndicator(
              indicatorHeight: 30.0,
              indicatorColor: Colors.white,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
            tabs: tabs,
            controller: _tabController,
          ),
        ),

        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            NewEvent(),
            NorthEvents(),
            SouthernEvents(),
            CentralEvents(),
            EasternEvents(),
            WesternEvents(),
            NortheastEvents(),
          ],
        ),

        // body: TabBarView(
        //   controller: _tabController,
        //   children: <Widget>[
        //     JanEvents(),
        //     FebEvents(),
        //     MarchEvents(),
        //     AprEvents(),
        //     MayEvents(),
        //     JuneEvents(),
        //     JulyEvents(),
        //     AugEvents(),
        //     SepEvents(),
        //     OctEvents(),
        //     NovEvents(),
        //     DecEvents()
        //   ],
        // ),
      ),
    );
  }
}

class PlaceContainer extends StatelessWidget {
  final String img;
  const PlaceContainer({
    Key key,
    this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(.3), BlendMode.srcOver),
          image: NetworkImage(img),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Spacer(),
          Text(
            "31 °",
            style: Theme.of(context)
                .textTheme
                .display1
                .apply(color: Colors.white, fontWeightDelta: 2),
          ),
          Text(
            "Sydney",
            style: Theme.of(context)
                .textTheme
                .headline
                .apply(color: Colors.white, fontWeightDelta: 2),
          )
        ],
      ),
    );
  }
}
