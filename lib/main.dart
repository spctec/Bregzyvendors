import 'package:bregzy_vendor/screens/add_coupons.dart';
import 'package:bregzy_vendor/screens/add_product.dart';
import 'package:bregzy_vendor/screens/home_screen.dart';
import 'package:bregzy_vendor/screens/login_screen.dart';
import 'package:bregzy_vendor/screens/products_lists.dart';
import 'package:bregzy_vendor/screens/reviesw.dart';
import 'package:bregzy_vendor/screens/splash_screen.dart';
import 'package:bregzy_vendor/screens/update_coupon.dart';
import 'package:bregzy_vendor/screens/vendor_store_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute: Splash_Screen.id,
      routes: {
        Splash_Screen.id: (context) => Splash_Screen(),
        LoginPage.id: (context) => LoginPage(),
        Home_Screen.id: (context) => Home_Screen(),
        ProductList.id: (context) => ProductList(),
        AddCoupon.id: (context) => AddCoupon(),
        UpdateCoupon.id: (context) => UpdateCoupon(),
        ReviewsScreen.id: (context) => ReviewsScreen(),
        VendorStoreScreen.id: (context) => VendorStoreScreen()
      },
    );
  }
}
