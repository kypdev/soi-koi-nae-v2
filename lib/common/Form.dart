import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/SignInButton.dart';
import 'package:soi_koi_nae_v2/common/loginAnimation.dart';
import './InputFields.dart';

class FormContainer extends StatefulWidget {
  @override
  _FormContainerState createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  AnimationController _loginButtonController;
  var animationStatus = 0;
  final FirebaseAuth auth = FirebaseAuth.instance;

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

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value.length < 13 || value.isEmpty) {
      return 'รูปแบบอีเมลล์ไม่ถูกต้องหรือคุณยังไม่ได้กรอกอีเมล';
    } else {
      return null;
    }
  }

  startSignin() {
    if (_formKey.currentState.validate()) {
      String email = emailCtrl.text.trim();
      String pass = passwordCtrl.text;

      auth.signInWithEmailAndPassword(email: email, password: pass).then((_) {
        // Navigator.pushReplacementNamed(context, '/home');
        setState(() {
          animationStatus = 1;
        });
        _playAnimation();
      }).catchError((e) => debugPrint('Err: $e'));

      print('signin: $email, $pass');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
              key: _formKey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new InputFieldArea(
                    label: 'อีเมล',
                    inputCtrl: emailCtrl,
                    obscure: false,
                    icon: Icons.person_outline,
                    val: emailValidator,
                  ),
                  new InputFieldArea(
                    inputCtrl: passwordCtrl,
                    label: 'รหัสผ่าน',
                    obscure: true,
                    icon: Icons.lock_outline,
                    val: (value) {
                      if (value.isEmpty || value.length < 6)
                        return 'รหัสผ่านห้ามว่างหรือต่ำกว่า 6 ตัวอักษร';
                      return null;
                    },
                  ),
                  animationStatus == 0
                      ? new Padding(
                          padding: const EdgeInsets.only(bottom: 25.0, top: 25.0),
                          child: new InkWell(
                            onTap: () => startSignin(),
                            child: SignIn(),
                          ),
                        )
                      : new StaggerAnimation(
                          buttonController: _loginButtonController.view),
                ],
              )),
        ],
      ),
    );
  }
}
