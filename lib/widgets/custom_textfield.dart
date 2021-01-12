import 'package:bregzy_vendor/constants.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Custom_TextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onclicked;
  final TextEditingController controller;
  String _errorMessage(String str) {
    switch (hint) {
      case "البريد الألكتروني":
        return "Email is Empty";
      case "كلمة المرور":
        return "Password is Empty";
    }
  }

  const Custom_TextField(
      {Key key, this.hint, this.icon, this.onclicked, this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50.0,
      ),
      child: TextFormField(
        textDirection: TextDirection.rtl,
        controller: controller,
        textAlign: TextAlign.end,
        validator: (value) {
          if (value.isEmpty) {
            return _errorMessage(hint);
            // ignore: missing_return
          }
          if (value.length < 8 && hint == "كلمة المرور") {
            return "Password must be equal 8 characters or more";
          }
          if (!value.contains("@") && hint == "البريد الألكتروني") {
            return "Email should be like example@email.com";
          }
          return null;
        },
        onSaved: onclicked,
        keyboardType: hint == "البريد الألكتروني"
            ? TextInputType.emailAddress
            : TextInputType.text,
        obscureText: hint == "كلمة المرور" || hint == "Conform your password"
            ? true
            : false,
        decoration: InputDecoration(
          suffixIcon: Icon(
            icon,
            color: KPurpleColor,
          ),
          hintText: hint,
          hintStyle: TextStyle(fontFamily: "Cairo"),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(width: 0.8, color: KPinkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(width: 1, color: KPinkColor)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(width: 1, color: KPinkColor)),
        ),
      ),
    );
  }
}
