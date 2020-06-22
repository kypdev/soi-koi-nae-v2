import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/form_signup.dart';
import 'package:soi_koi_nae_v2/common/styles.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  var animationStatus = 0;

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: new BoxDecoration(
            image: signupBackgroundImage,
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
                        Container(
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 35.0,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'สมัครสมาชิก',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FormSignup(),
                      ],
                    ),
                    animationStatus == 0
                        ? new Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: new InkWell(
                              onTap: () {
                                setState(() {
                                  animationStatus = 1;
                                });
                                _playAnimation();
                              },
                              child: Container(),

                              // new SignIn(),
                            ),
                          )
                        : Container(),

                    // new StaggerAnimation(
                    //     buttonController: _loginButtonController.view),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
