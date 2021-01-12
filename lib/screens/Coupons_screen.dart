import 'dart:ui';

import 'package:bregzy_vendor/models/coupons.dart';
import 'package:bregzy_vendor/screens/add_coupons.dart';
import 'package:bregzy_vendor/screens/home_screen.dart';
import 'package:bregzy_vendor/screens/update_coupon.dart';
import 'package:bregzy_vendor/services/network.dart';
import 'package:bregzy_vendor/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class CouponsScreen extends StatefulWidget {
  @override
  _CouponsScreenState createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  Coupons coupons;
  bool islouding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  color: KPurpleColor,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50.0))),
              child: FutureBuilder(
                future: getVendorData(),
                builder: (context, snapshot) {
                  // ignore: non_constant_identifier_names
                  var wp_vendors = snapshot.data;
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          wp_vendors['store_name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                        Text(
                          wp_vendors['email'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21.0,
                          ),
                        )
                      ],
                    );
                  } else {
                    return Text("");
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_Screen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "الصفحه الرئيسيه",
                      style: TextStyle(fontFamily: "Cairo"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.home,
                      size: 30.0,
                      color: KPinkColor,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("السحب", style: TextStyle(fontFamily: "Cairo")),
                  SizedBox(
                    width: 25,
                  ),
                  FaIcon(FontAwesomeIcons.moneyCheckAlt, color: KPinkColor),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("الخطط", style: TextStyle(fontFamily: "Cairo")),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.offline_pin, size: 30.0, color: KPinkColor),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("الكوبونات", style: TextStyle(fontFamily: "Cairo")),
                  SizedBox(
                    width: 18,
                  ),
                  FaIcon(FontAwesomeIcons.ticketAlt,
                      size: 30.0, color: KPinkColor),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("الاعدادات", style: TextStyle(fontFamily: "Cairo")),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.settings, size: 30.0, color: KPinkColor),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("تسجيل الخروج", style: TextStyle(fontFamily: "Cairo")),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.logout, size: 30.0, color: KPinkColor),
                ],
              ),
            ),
          ],
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: islouding,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Custom_Header(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Divider(
                  thickness: 1.8,
                ),
              ),
              Container(
                height: 50,
                width: 80,
                decoration: BoxDecoration(
                  color: KOrangeColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: InkWell(
                  child: Center(
                      child: Text("اضف كوبون   ",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Cairo",
                            fontSize: 10.0,
                          ))),
                  onTap: () {
                    Navigator.pushNamed(context, AddCoupon.id);
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FutureBuilder(
                    future: getCoupons(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.855,
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, index) {
                              var coupons = snapshot.data[index];
                              debugPrint("${coupons['code']}");
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    height: 110,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: KOrangeColor, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "كود",
                                                    style: TextStyle(
                                                        color: KPinkColor,
                                                        fontFamily: "Cairo",
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                    "${coupons['code']}",
                                                    style: TextStyle(
                                                        color: KPurpleColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: VerticalDivider(
                                                  thickness: 1.2,
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "نوع الكبون",
                                                    style: TextStyle(
                                                        color: KPinkColor,
                                                        fontFamily: "Cairo",
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "${coupons['discount_type']}",
                                                    style: TextStyle(
                                                        color: KPurpleColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: VerticalDivider(
                                                  thickness: 1.2,
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "كميه",
                                                    style: TextStyle(
                                                        color: KPinkColor,
                                                        fontFamily: "Cairo",
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                    "${coupons['amount']}%",
                                                    style: TextStyle(
                                                        color: KPurpleColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: VerticalDivider(
                                                  thickness: 1.2,
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                  Text(
                                                    "الاستخدام/الحدود",
                                                    style: TextStyle(
                                                        color: KPinkColor,
                                                        fontFamily: "Cairo",
                                                        fontSize: 10),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "${coupons['usage_count']}/${coupons['usage_limit']}",
                                                    style: TextStyle(
                                                        color: KPurpleColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UpdateCoupon(
                                                              coupons: coupons,
                                                            )));
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    color: KPinkColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Center(
                                                    child: Text(
                                                  "تعديل",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Cairo"),
                                                )),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            InkWell(
                                              child: Container(
                                                height: 30,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    color: Colors.red[700],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Center(
                                                    child: Text(
                                                  "حذف",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Cairo"),
                                                )),
                                              ),
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Directionality(
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        child: AlertDialog(
                                                          title: new Text(
                                                            'تأكيد',
                                                            style: GoogleFonts.cairo(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          content: new Text(
                                                            'هل أنت متأكد من رغبتك فى حذف الكوبون ؟',
                                                            style: GoogleFonts.cairo(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          actions: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                FlatButton(
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        DeleteCoupon(coupons['id'].hashCode)
                                                                            .whenComplete(() {});
                                                                        Navigator.pop(
                                                                            context);
                                                                      });
                                                                    },
                                                                    child: Text(
                                                                      "موافق",
                                                                      style: GoogleFonts.cairo(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              KPinkColor),
                                                                    )),
                                                                FlatButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        "إلغاء",
                                                                        style: GoogleFonts.cairo(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: KPurpleColor))),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
