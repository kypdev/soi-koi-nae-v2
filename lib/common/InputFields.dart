import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final String label;
  final bool obscure;
  final IconData icon;
  final Function val;
  final TextEditingController inputCtrl;
  InputFieldArea({this.hint, this.obscure, this.icon, this.val, this.inputCtrl, this.label});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            width: 0.5,
            color: Colors.white24,
          ),
        ),
      ),
      child: new TextFormField(
        controller: inputCtrl,
        obscureText: obscure,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: new InputDecoration(
          icon: new Icon(
            icon,
            color: Colors.white,
          ),
          border: InputBorder.none,
          // hintText: hint,
          labelText: label,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
          contentPadding: const EdgeInsets.only(
              top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
        ),
        validator: val,
      ),
    ));
  }
}
