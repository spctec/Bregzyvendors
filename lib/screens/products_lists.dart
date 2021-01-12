import 'package:bregzy_vendor/screens/Coupons_screen.dart';
import 'package:bregzy_vendor/screens/add_product.dart';
import 'package:bregzy_vendor/screens/home_screen.dart';
import 'package:bregzy_vendor/screens/products_details.dart';
import 'package:bregzy_vendor/screens/update_product.dart';
import 'package:bregzy_vendor/services/network.dart';
import 'package:bregzy_vendor/widgets/custom_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class ProductList extends StatefulWidget {
  static String id = "ProductList";

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getProducts();
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CouponsScreen()));
                },
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
      body: ListView(children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Custom_Header(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Divider(
                thickness: 1.8,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewProducts()));
                    },
                    child: Text(
                      "اضف منتج",
                      style:
                          TextStyle(fontFamily: "Cairo", color: Colors.white),
                    ),
                    color: KPinkColor,
                  ),
                )
              ],
            ),
            FutureBuilder(
              future: getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.885,
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map wpproducts = snapshot.data[index];
                          return Column(
                            children: [
                              Divider(
                                thickness: 1.8,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        width: 30,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: KPurpleColor,
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Editproducts(
                                                          products: wpproducts,
                                                        )));
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        width: 30,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.red[700],
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: InkWell(
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
                                                        style:
                                                            GoogleFonts.cairo(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      content: new Text(
                                                        'هل أنت متأكد من رغبتك فى حذف المنتج ؟',
                                                        style:
                                                            GoogleFonts.cairo(
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
                                                                onPressed: () {
                                                                  setState(() {
                                                                    DeleteProducts(wpproducts[
                                                                            'id'])
                                                                        .whenComplete(
                                                                            () {});
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                },
                                                                child: Text(
                                                                  "موافق",
                                                                  style: GoogleFonts.cairo(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color:
                                                                          KPinkColor),
                                                                )),
                                                            FlatButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    "إلغاء",
                                                                    style: GoogleFonts.cairo(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color:
                                                                            KPurpleColor))),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //ProductsCard(wpproducts: wpproducts),
                                  InkWell(
                                    child: Container(
                                      // margin: EdgeInsets.only(left: 50.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white54.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(8.3),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      height: 120.0,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${wpproducts['name']}",
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontFamily: "Cairo"),
                                                  ),
                                                  Text(
                                                    " :اسم المنتج",
                                                    style: TextStyle(
                                                        color: KPinkColor,
                                                        fontFamily: "Cairo"),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                  "${wpproducts["regular_price"]}"),
                                              Text(
                                                ": سعر المنتج",
                                                style: TextStyle(
                                                    color: KPinkColor,
                                                    fontFamily: "Cairo"),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                  "${wpproducts["sale_price"]}"),
                                              Text(
                                                ": سعر المنتج بعد الخصم",
                                                style: TextStyle(
                                                    color: KPinkColor,
                                                    fontFamily: "Cairo"),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetails(
                                                    wpporducts: wpproducts,
                                                  )));
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 8.0, left: 8.0, right: 8.0),
                                    child: Material(
                                      elevation: 3.0,
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Container(
                                        height: 120,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    wpproducts['images'][0]
                                                        ['src'])),
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                  );
                } else {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: KOrangeColor,
                        ),
                      ));
                }
              },
            ),
          ],
        ),
      ]),
    );
  }
}
