import 'package:bregzy_vendor/services/network.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

class Custom_Header extends StatelessWidget {
  final Function function;

  const Custom_Header({Key key, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('MMM,yyyy/dd');
    String formattedDate = formatter.format(now);

    return FutureBuilder(
      future: getVendorData(),
      builder: (context, snapshot) {
        var wpVendor = snapshot.data;
        if (snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: KPurpleColor),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage("${wpVendor["gravatar"]}"),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, ${wpVendor['store_name']}",
                    style: TextStyle(fontSize: 40),
                  ),
                  Text("$formattedDate"),
                ],
              ),
              Column(
                children: [
                  IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.equals,
                        color: KOrangeColor,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      }),
                  SizedBox(
                    height: 28,
                  )
                ],
              ),
            ],
          );
        } else {
          return Text("");
        }
      },
    );
  }
}
