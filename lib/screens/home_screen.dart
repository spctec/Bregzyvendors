import 'package:bregzy_vendor/constants.dart';
import 'package:bregzy_vendor/screens/Coupons_screen.dart';
import 'package:bregzy_vendor/screens/products_lists.dart';
import 'package:bregzy_vendor/screens/reviesw.dart';
import 'package:bregzy_vendor/screens/vendor_store_screen.dart';
import 'package:bregzy_vendor/services/network.dart';
import 'package:bregzy_vendor/widgets/custom_header.dart';
import 'package:bregzy_vendor/widgets/products_buttons.dart';
import 'package:bregzy_vendor/widgets/report_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';
import 'orders.dart';

class Home_Screen extends StatefulWidget {
  static String id = 'Home_Screen';

  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  Future vendor ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vendor = getVendorData();
  }

  save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey _scaffoldKey = new GlobalKey();
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
                future: vendor,
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Screen()));
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
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CouponsScreen()));
                },
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
              child: InkWell(
                onTap: () {
                  save(null);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
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
            ),
          ],
        ),
      ),
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: Custom_Header(
                  function: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 10.0),
                child: Divider(
                  thickness: 1.8,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("This Month"),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "All Reports",
                    style: TextStyle(color: KPinkColor),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  report_widget(
                    icon: FaIcon(FontAwesomeIcons.moneyBillWave),
                    iconBackground: KPurpleColor,
                    precientage: true,
                    reportType: "إجمالي المبيعات",
                    reportTypeColor: KPinkColor,
                  ),
                  report_widget(
                    icon: FaIcon(FontAwesomeIcons.solidMoneyBillAlt),
                    iconBackground: KOrangeColor,
                    precientage: true,
                    reportType: "أرباح",
                    reportTypeColor: KPurpleColor,
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  report_widget(
                    icon: FaIcon(FontAwesomeIcons.box),
                    iconBackground: KPurpleColor,
                    precientage: false,
                    reportType: "تم البيع",
                    reportTypeColor: KPinkColor,
                  ),
                  report_widget(
                    icon: FaIcon(FontAwesomeIcons.newspaper),
                    iconBackground: KPinkColor,
                    precientage: false,
                    reportType: "طلب وارد",
                    reportTypeColor: KOrangeColor,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 10.0),
                child: Divider(
                  thickness: 1.8,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductButton(
                    icon: FontAwesomeIcons.boxes,
                    color: KOrangeColor,
                    productsOp: "منتجات",
                    function: () =>
                        Navigator.pushNamed(context, ProductList.id),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductButton(
                    icon: FontAwesomeIcons.ticketAlt,
                    color: KPinkColor,
                    productsOp: "كوبونات",
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CouponsScreen()));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductButton(
                    icon: FontAwesomeIcons.shippingFast,
                    color: KPurpleColor,
                    productsOp: "طلبات",
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrdersScreen()));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductButton(
                    icon: FontAwesomeIcons.moneyCheckAlt,
                    color: KOrangeColor,
                    productsOp: "السحب",
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductButton(
                    icon: FontAwesomeIcons.store,
                    color: KPinkColor,
                    productsOp: "المحل الخاص بك",
                    function: () {
                      Navigator.pushNamed(context, VendorStoreScreen.id);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductButton(
                    icon: EvaIcons.people,
                    color: KPurpleColor,
                    productsOp: "المراجعات",
                    function: () {
                      Navigator.pushNamed(context, ReviewsScreen.id);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
