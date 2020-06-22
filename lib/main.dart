import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/views/main_page.dart';
import 'package:soi_koi_nae_v2/views/user_profile.dart';

import 'views/login_screen.dart';
import 'views/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Kanit',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => MainPage(),
        '/profile': (context) => UserProfile(),
      },
    );
  }
}
