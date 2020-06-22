import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/logout_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              Image.network('https://firebasestorage.googleapis.com/v0/b/soi-koi-nae.appspot.com/o/%E0%B8%B5userprofile%2Fimage_picker1275587429094664913.jpg?alt=media&token=b50b716f-bee3-4422-b9a2-2e5b84437b6e',),
              InkWell(
                onTap: () => signOut(context),
                child: LogoutButton(),
              ),
            ],
          )),
    );
  }
}
