import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/services.dart';
import 'package:soi_koi_nae_v2/common/Form.dart';
import 'package:soi_koi_nae_v2/common/SignUpLink.dart';
import 'package:soi_koi_nae_v2/common/WhiteTick.dart';
import 'package:soi_koi_nae_v2/common/styles.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  var animationStatus = 0;
  @override
  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Are you sure?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, "/home"),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return (new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          body: new Container(
            decoration: new BoxDecoration(
              image: backgroundImage,
            ),
            child: new Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                colors: <Color>[
                  const Color.fromRGBO(162, 146, 199, 0.8),
                  const Color.fromRGBO(51, 51, 63, 0.9),
                ],
                stops: [0.2, 1.0],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
              )),
              child: new ListView(
                padding: const EdgeInsets.all(0.0),
                children: <Widget>[
                  new Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Tick(image: tick),
                          new FormContainer(),
                          new SignUp(),
                        ],
                      ),
                      // animationStatus == 0
                      //     ? new Padding(
                      //         padding: const EdgeInsets.only(bottom: 50.0),
                      //         child: new InkWell(
                      //             onTap: () {
                      //               if(){

                      //               }
                      //               setState(() {
                      //                 animationStatus = 1;
                      //               });
                      //               _playAnimation();
                      //             },
                      //             child: new SignIn()),
                      //       )
                      //     : new StaggerAnimation(
                      //         buttonController: _loginButtonController.view),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
