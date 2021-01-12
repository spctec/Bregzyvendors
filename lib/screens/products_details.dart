import 'package:auto_size_text/auto_size_text.dart';
import 'package:bregzy_vendor/constants.dart';
import 'package:bregzy_vendor/services/network.dart';
import 'package:bregzy_vendor/widgets/custom_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductDetails extends StatelessWidget {
  final Map wpporducts;

  const ProductDetails({Key key, this.wpporducts}) : super(key: key);
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "اضافة منتج",
                    style: TextStyle(fontFamily: "Cairo"),
                  ),
                  SizedBox(
                    width: 19,
                  ),
                  Icon(
                    Icons.add,
                    size: 30.0,
                    color: KPinkColor,
                  ),
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
                  Text(
                    "حذف منتج",
                    style: TextStyle(fontFamily: "Cairo"),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Icon(
                    Icons.remove,
                    size: 30.0,
                    color: KPinkColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "تجديد منتج",
                    style: TextStyle(fontFamily: "Cairo"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.update,
                    size: 30.0,
                    color: KPinkColor,
                  ),
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
                  Text("السحب", style: TextStyle(fontFamily: "Cairo")),
                  SizedBox(
                    width: 30,
                  ),
                  FaIcon(FontAwesomeIcons.moneyCheckAlt, color: KPinkColor),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("الخطط", style: TextStyle(fontFamily: "Cairo")),
                  SizedBox(
                    width: 22,
                  ),
                  Icon(Icons.offline_pin, size: 30.0, color: KPinkColor),
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
                  Text("الكوبونات", style: TextStyle(fontFamily: "Cairo")),
                  SizedBox(
                    width: 27,
                  ),
                  FaIcon(FontAwesomeIcons.ticketAlt,
                      size: 30.0, color: KPinkColor),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("الاعدادات", style: TextStyle(fontFamily: "Cairo")),
                  SizedBox(
                    width: 30,
                  ),
                  Icon(Icons.settings, size: 30.0, color: KPinkColor),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Custom_Header(),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(wpporducts['images'][0]['src']),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30.00),
                        bottomLeft: Radius.circular(30.0)),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          KPurpleColor.withOpacity(0.1),
                          Colors.white.withOpacity(0.1)
                        ]),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    wpporducts['name'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                  Text(
                    " : اسم المنتج",
                    style: TextStyle(
                        color: KPurpleColor,
                        fontFamily: "Cairo",
                        fontSize: 20.0),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 30.0,
                  ),
                  Flexible(child: Text(wpporducts['short_description'])),
                  SizedBox(
                    width: 30.0,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(
                  thickness: 1.8,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 30.0,
                  ),
                  Text(" : شرح المنتج",
                      style: TextStyle(
                          color: KPurpleColor,
                          fontFamily: "Cairo",
                          fontSize: 20.0)),
                  SizedBox(
                    width: 30.0,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 30.0,
                  ),
                  Flexible(child: Text(wpporducts['description'])),
                  SizedBox(
                    width: 30.0,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(
                  thickness: 1.8,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 30.0,
                  ),
                  Row(
                    children: [
                      Text(wpporducts['sale_price']),
                      Text(" : سعر بعد الخصم    ",
                          style: TextStyle(
                              color: KPurpleColor,
                              fontFamily: "Cairo",
                              fontSize: 15.0)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(wpporducts['regular_price']),
                      AutoSizeText(" : سعر المنتج",
                          maxLines: 1,
                          minFontSize: 10,
                          style: TextStyle(
                              color: KPurpleColor,
                              fontFamily: "Cairo",
                              fontSize: 15.0)),
                    ],
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(
                  thickness: 1.8,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 30.0,
                  ),
                  Row(
                    children: [
                      Text("${wpporducts['total_sales']}"),
                      Text(" : مجموع المبيعات",
                          style: TextStyle(
                              color: KPurpleColor,
                              fontFamily: "Cairo",
                              fontSize: 15.0)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        wpporducts['categories'][0]['name'],
                        style: TextStyle(fontFamily: "Cairo", fontSize: 15.0),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      AutoSizeText(" : نوع المنتج",
                          maxLines: 1,
                          minFontSize: 10,
                          style: TextStyle(
                              color: KPurpleColor,
                              fontFamily: "Cairo",
                              fontSize: 15.0)),
                    ],
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
