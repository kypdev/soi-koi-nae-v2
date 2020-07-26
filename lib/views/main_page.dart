import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/featuredcontainer.dart';
import 'package:soi_koi_nae_v2/common/global.dart';
import 'package:soi_koi_nae_v2/common/mydropdownbutton.dart';
import 'package:soi_koi_nae_v2/common/mymenu.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:soi_koi_nae_v2/views/months/apr_event.dart';
import 'package:soi_koi_nae_v2/views/months/aug_event.dart';
import 'package:soi_koi_nae_v2/views/months/dec_event.dart';
import 'package:soi_koi_nae_v2/views/months/feb_event.dart';
import 'package:soi_koi_nae_v2/views/months/jan_event.dart';
import 'package:soi_koi_nae_v2/views/months/july_event.dart';
import 'package:soi_koi_nae_v2/views/months/june_event.dart';
import 'package:soi_koi_nae_v2/views/months/march_event.dart';
import 'package:soi_koi_nae_v2/views/months/may_event.dart';
import 'package:soi_koi_nae_v2/views/months/nov_event.dart';
import 'package:soi_koi_nae_v2/views/months/oct_event.dart';
import 'package:soi_koi_nae_v2/views/months/sep_event.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    new Tab(text: "มกราคม"),
    new Tab(text: "กุมภาพันธ์"),
    new Tab(text: "มีนาคม"),
    new Tab(text: "เมษายน"),
    new Tab(text: "พฤษภาคม"),
    new Tab(text: "มิถุนายน"),
    new Tab(text: "กรกฎาคม"),
    new Tab(text: "สิงหาคม"),
    new Tab(text: "กันยายน"),
    new Tab(text: "ตุลาคม"),
    new Tab(text: "พฤศจิกายน"),
    new Tab(text: "ธันวาคม"),
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
          // title: Text('Bubble Tab Indicator'),
          title: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MyDropDownButton(),
                // IconButton(
                //   icon: CircleAvatar(
                //     backgroundImage: NetworkImage(profilePicture),
                //   ),
                //   onPressed: () => showProfile(),
                // ),
                StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(userID)
              .snapshots(),
          builder: (context, sn) {
            if (!sn.hasData) {
              return Text('Loading data Please wait...');
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 75.0,
                      child: CircleAvatar(
                        radius: 70.0,
                        backgroundColor: Color(0XFFFFFFFF),
                        backgroundImage: NetworkImage(sn.data['imgpro']),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
              ],
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
            JanEvents(),
            FebEvents(),
            MarchEvents(),
            AprEvents(),
            MayEvents(),
            JuneEvents(),
            JulyEvents(),
            AugEvents(),
            SepEvents(),
            OctEvents(),
            NovEvents(),
            DecEvents()
            
          ],
        ),
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
