import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/logout_button.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  signOut(context) {
    auth
        .signOut()
        .then((_) => Navigator.pushReplacementNamed(context, '/login'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('home screen'),
        ),
        body: Column(
          children: <Widget>[
            // Image.network('',),
            InkWell(
              onTap: () => signOut(context),
              child: LogoutButton(),
            ),
          ],
        ),
      ),
    );
  }
}
