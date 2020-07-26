import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/cus_appbar.dart';
import 'package:soi_koi_nae_v2/views/regions/event_detail.dart';

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
        body: Column(
          children: <Widget>[
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetail()));
              },
                            child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, bottom: 16.0, left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Event AAA',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '19/08/2020',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://www.sansiri.com/uploads/news/2018/09/27/650_dc983cd7-dba1-4bc1-b539-30093e8000a4.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
         

         SizedBox(height: 30.0),


          Container(
            height: 230.0,
              // margin: EdgeInsets.all(15),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: 7, color: Colors.grey, offset: Offset(0, 5))
              ], 
              
              // borderRadius: BorderRadius.circular(15)
              ),
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.grey.withOpacity(.3), BlendMode.srcOver),
                        image: NetworkImage('https://www.sansiri.com/uploads/news/2018/09/27/650_dc983cd7-dba1-4bc1-b539-30093e8000a4.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "AAAAAAAA",
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .apply(color: Colors.white),
                        ),
                        SizedBox(height: 9),
                        Text(
                          "19/05/2020",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .apply(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
