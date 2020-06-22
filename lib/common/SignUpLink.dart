import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/views/signup_screen.dart';

class SignUp extends StatelessWidget {
  SignUp();
  goSignupScreen(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return (new FlatButton(
      padding: const EdgeInsets.only(
        top: 160.0,
      ),
      onPressed: null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            "Don't have an account?  ",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: new TextStyle(
                fontWeight: FontWeight.w300,
                letterSpacing: 0.5,
                color: Colors.white,
                fontSize: 14.0),
          ),
          InkWell(
            onTap: (){
              goSignupScreen(context);
            },
                      child: Text(
              'Signup',
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: Colors.white,
                  fontSize: 14.0),
            ),
          ),
        ],
      ),
    ));
  }
}
