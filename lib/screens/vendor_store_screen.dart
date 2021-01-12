import 'package:bregzy_vendor/constants.dart';
import 'package:bregzy_vendor/services/network.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VendorStoreScreen extends StatelessWidget {
  static String id = 'VendorStoreScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getVendorData(),
            builder: (context, snapshot) {
              var vendor = snapshot.data;
              if (snapshot.hasData) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.equals,
                                  color: KOrangeColor,
                                ),
                                onPressed: null),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: KOrangeColor,
                                ),
                                onPressed: null),
                          ),
                        ],
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 160,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Image.network(
                                    "${vendor['gravatar']}",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  height: 160,
                                  width:
                                      MediaQuery.of(context).size.width * 0.53,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text("First Name:",
                                              style: TextStyle(
                                                  color: KPurpleColor,
                                                  fontSize: 15.0)),
                                          Text(
                                            "${vendor['first_name']}",
                                            style: TextStyle(
                                                color: KPinkColor,
                                                fontSize: 15.0),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Text("Last Name:",
                                              style: TextStyle(
                                                  color: KPurpleColor,
                                                  fontSize: 15.0)),
                                          Text(
                                            "${vendor['last_name']}",
                                            style: TextStyle(
                                                color: KPinkColor,
                                                fontSize: 15.0),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Text("Store Name:",
                                              style: TextStyle(
                                                  color: KPurpleColor,
                                                  fontSize: 15.0)),
                                          Text(
                                            "${vendor['store_name']}",
                                            style: TextStyle(
                                                color: KPinkColor,
                                                fontSize: 15.0),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Text("Email:",
                                              style: TextStyle(
                                                  color: KPurpleColor,
                                                  fontSize: 15.0)),
                                          Text(
                                            "${vendor['email']}",
                                            style: TextStyle(
                                                color: KPinkColor,
                                                fontSize: 15.0),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Text("Phone Number:",
                                              style: TextStyle(
                                                  color: KPurpleColor,
                                                  fontSize: 15.0)),
                                          Text(
                                            "${vendor['phone']}",
                                            style: TextStyle(
                                                color: KPinkColor,
                                                fontSize: 15.0),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Address",
                                        style: TextStyle(
                                            color: KPurpleColor,
                                            fontSize: 20.0),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 130),
                                    child: Divider(
                                      thickness: 1.8,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("Street 1:",
                                          style: TextStyle(
                                              color: KPurpleColor,
                                              fontSize: 15.0)),
                                      Text(
                                        "${vendor['address']['street_1']}",
                                        style: TextStyle(
                                            color: KPinkColor, fontSize: 15.0),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("Street 2:",
                                          style: TextStyle(
                                              color: KPurpleColor,
                                              fontSize: 15.0)),
                                      Text(
                                        "${vendor['address']['street_2']}",
                                        style: TextStyle(
                                            color: KPinkColor, fontSize: 15.0),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("City:",
                                          style: TextStyle(
                                              color: KPurpleColor,
                                              fontSize: 15.0)),
                                      Text(
                                        "${vendor['address']['city']}",
                                        style: TextStyle(
                                            color: KPinkColor, fontSize: 15.0),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("ZIP:",
                                          style: TextStyle(
                                              color: KPurpleColor,
                                              fontSize: 15.0)),
                                      Text(
                                        "${vendor['address']['zip']}",
                                        style: TextStyle(
                                            color: KPinkColor, fontSize: 15.0),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("State:",
                                          style: TextStyle(
                                              color: KPurpleColor,
                                              fontSize: 15.0)),
                                      Text(
                                        "${vendor['address']['state']}",
                                        style: TextStyle(
                                            color: KPinkColor, fontSize: 15.0),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("Country:",
                                          style: TextStyle(
                                              color: KPurpleColor,
                                              fontSize: 15.0)),
                                      Text(
                                        "${vendor['address']['country']}",
                                        style: TextStyle(
                                            color: KPinkColor, fontSize: 15.0),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: KPurpleColor,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
