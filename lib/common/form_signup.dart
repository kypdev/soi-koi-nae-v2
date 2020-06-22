import 'package:flutter/material.dart';
import 'package:soi_koi_nae_v2/common/signup_button.dart';

import 'InputFields.dart';

class FormSignup extends StatefulWidget {
  @override
  _FormSignupState createState() => _FormSignupState();
}

class _FormSignupState extends State<FormSignup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstnameCtrl = new TextEditingController();
  TextEditingController lastnameCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  TextEditingController conpasswordCtrl = new TextEditingController();

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

  void startSignup() {
    if (_formKey.currentState.validate()) {
      String fname = firstnameCtrl.text.trim();
      String lname = lastnameCtrl.text.trim();
      String email = emailCtrl.text.trim();
      String pass = passwordCtrl.text;
      String conpass = conpasswordCtrl.text;

      print('signup: $fname, $lname, $email, $pass, $conpass');
    }
  }

  @override
  void dispose() {
    super.dispose();
    firstnameCtrl.clear();
    lastnameCtrl.clear();
    emailCtrl.clear();
    passwordCtrl.clear();
    conpasswordCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            InputFieldArea(
              inputCtrl: firstnameCtrl,
              label: 'ชื่อ',
              obscure: false,
              icon: Icons.person_outline,
              val: (value) {
                if (value.isEmpty || value.length < 2)
                  return 'ชื่อห้ามว่างหรือต่ำกว่า 2 ตัวอักษร';
                return null;
              },
            ),
            InputFieldArea(
              inputCtrl: lastnameCtrl,
              label: 'นามสกุล',
              obscure: false,
              icon: Icons.person_outline,
              val: (value) {
                if (value.isEmpty || value.length < 2)
                  return 'นามสกุลห้ามว่างหรือต่ำกว่า 2 ตัวอักษร';
                return null;
              },
            ),
            InputFieldArea(
              inputCtrl: emailCtrl,
              label: 'อีเมล',
              obscure: false,
              icon: Icons.person_outline,
              val: emailValidator,
            ),
            InputFieldArea(
              inputCtrl: passwordCtrl,
              label: 'รหัสผ่าน',
              obscure: true,
              icon: Icons.person_outline,
              val: (value) {
                if (value.isEmpty || value.length < 6)
                  return 'รหัสผ่านห้ามว่างหรือต่ำกว่า 6 ตัวอักษร';
                return null;
              },
            ),
            InputFieldArea(
              inputCtrl: conpasswordCtrl,
              label: 'ยืนยันรหัสผ่าน',
              obscure: true,
              icon: Icons.person_outline,
              val: (value) {
                if (value.isEmpty || value.length < 6)
                  return 'รหัสผ่านห้ามว่างหรือต่ำกว่า 6 ตัวอักษร';
                return null;
              },
            ),
            SizedBox(height: 28.0),
            InkWell(
              onTap: () => startSignup(),
              child: SignupButton(),
            ),
          ],
        ),
      ),
    );
  }
}
