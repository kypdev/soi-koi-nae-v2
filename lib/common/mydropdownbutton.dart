import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/views/regions/central_events.dart';
import 'package:soi_koi_nae_v2/views/regions/eastern_events.dart';
import 'package:soi_koi_nae_v2/views/regions/north_events.dart';
import 'package:soi_koi_nae_v2/views/regions/northeast_events.dart';
import 'package:soi_koi_nae_v2/views/regions/southern_events.dart';
import 'package:soi_koi_nae_v2/views/regions/western_events.dart';

class MyDropDownButton extends StatefulWidget {
  const MyDropDownButton({
    Key key,
  }) : super(key: key);

  @override
  _MyDropDownButtonState createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  int _active = 0;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _active,
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Kanit',
      ),

      onChanged: (i) {
        setState(() {
          _active = i;
        });

        switch (i) {
          case 0:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NorthEvents()));
            break;
          case 1:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SouthernEvents()));
            break;
          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CentralEvents()));
            break;
          case 3:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EasternEvents()));
            break;
          case 4:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WesternEvents()));
            break;
          case 5:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NortheastEvents()));
            break;
        }
      },
      underline: Container(),
      items: [
        DropdownMenuItem(
          child: Text("ภาคเหนือ"),
          value: 0,
        ),
        DropdownMenuItem(
          child: Text("ภาคใต้"),
          value: 1,
        ),
        DropdownMenuItem(
          child: Text("ภาคกลาง"),
          value: 2,
        ),
        DropdownMenuItem(
          child: Text("ภาคตะวันออก"),
          value: 3,
        ),
        DropdownMenuItem(
          child: Text("ภาคตะวันตก"),
          value: 4,
        ),
        DropdownMenuItem(
          child: Text("ภาคตะวันออกเฉียงเหนือ"),
          value: 5,
        ),
      ],
    );
  }
}
