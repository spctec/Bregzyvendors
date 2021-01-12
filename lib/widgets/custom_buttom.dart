import 'package:flutter/material.dart';

import '../constants.dart';

// ignore: camel_case_types
class Custom_buttom extends StatelessWidget {
  final String opname;
  final Function onpressed;

  const Custom_buttom({Key key, this.opname, this.onpressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(40),
      elevation: 6.0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                KPurpleColor,
                // KPinkColor ,
                KOrangeColor
              ]),
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: FlatButton(
          child: Text(
            opname,
            style: TextStyle(
                fontFamily: "Cairo", color: Colors.white, fontSize: 13.0),
          ),
          onPressed: onpressed,
        ),
      ),
    );
  }
}
