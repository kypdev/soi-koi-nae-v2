import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  final img;
  final title;
  final date;

  const EventItem({Key key, this.img, this.title, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        height: 230.0,
        // margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          boxShadow: [
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
                  image: NetworkImage(img),
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
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    fontWeight: FontWeight.bold,
                    
                    ),
                  ),
                  SizedBox(height: 9),
                  Text(
                    date,
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
    );
  }
}
