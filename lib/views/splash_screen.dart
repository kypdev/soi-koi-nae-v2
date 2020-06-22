import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      auth.currentUser().then((user) {
        if (user != null) {
          print('go home screen');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tourism',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              SizedBox(height: 30.0),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
