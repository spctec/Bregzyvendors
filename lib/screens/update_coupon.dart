import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bregzy_vendor/constants.dart';
import 'package:bregzy_vendor/models/coupons.dart';
import 'package:bregzy_vendor/services/network.dart';
import 'package:bregzy_vendor/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class UpdateCoupon extends StatefulWidget {
  static String id = 'UpdateCoupon';
  Map coupons;
  UpdateCoupon({this.coupons});
  @override
  _UpdateCouponState createState() => _UpdateCouponState();
}

class _UpdateCouponState extends State<UpdateCoupon> {
  List myActivities;
  String _myActivitiesResult;
  String couponName;
  String couponAmount;
  String usageLimit;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    myActivities = [];
    _myActivitiesResult = '';
  }

  Future<void> addedAlert() async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.TOPSLIDE,
      padding: EdgeInsets.all(0),
      title: "تأكيد",
      desc: "تم اضافة الكوبون بنجاح",
      dismissOnTouchOutside: true,
      headerAnimationLoop: false,
    ).show();
  }

  Future<void> FiledAlert() async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.TOPSLIDE,
      padding: EdgeInsets.all(0),
      title: "خطأ",
      desc: "هناك خطأ فى الكوبون ",
      dismissOnTouchOutside: true,
      headerAnimationLoop: false,
    ).show();
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        addCoupons(
                code: couponName,
                amount: couponAmount,
                usageLimit: int.parse(usageLimit),
                productsIds: myActivities)
            .whenComplete(() {
          Navigator.pop(context);
          addedAlert();
          setState(() {});
        });
      });
    }
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Custom_Header(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Divider(thickness: 1.8),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .885,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: FutureBuilder(
                        future: getProducts(),
                        builder: (context, snapshot) {
                          var products = snapshot.data;

                          if (snapshot.hasData) {
                            List productsIds = widget.coupons['product_ids'];
                            List<String> initProductnames = [];
                            debugPrint("$productsIds");
                            List<Map> list = [];
                            for (var i = 0; i < products.length; i++) {
                              list.add({
                                "display": products[i]["name"],
                                "value": products[i]["id"]
                              });
                            }
                            for (var i = 0; i < productsIds.length; i++) {
                              for (var j = 0; j < list.length; j++) {
                                if (productsIds[i] == list[j]['value']) {
                                  initProductnames.add(list[j]['display']);
                                }
                              }
                            }
                            print(initProductnames);
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0,
                                      ),
                                      child: TextFormField(
                                        onSaved: (value) {
                                          couponName = value;
                                        },
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          hintText: "اسم الكوبون",
                                          hintStyle:
                                              TextStyle(fontFamily: "Cairo"),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide(
                                                  width: 0.8,
                                                  color: KPinkColor)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide(
                                                  width: 1, color: KPinkColor)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide(
                                                  width: 1, color: KPinkColor)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50.0, vertical: 16.0),
                                      child: TextFormField(
                                        onSaved: (value) {
                                          couponAmount = value;
                                        },
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          hintText: "الكميه",
                                          hintStyle:
                                              TextStyle(fontFamily: "Cairo"),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide(
                                                  width: 0.8,
                                                  color: KPinkColor)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide(
                                                  width: 1, color: KPinkColor)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide(
                                                  width: 1, color: KPinkColor)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0,
                                      ),
                                      child: TextFormField(
                                        textAlign: TextAlign.start,
                                        onSaved: (value) {
                                          usageLimit = value;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "الحد الاقصى من الاستخدام",
                                          hintStyle:
                                              TextStyle(fontFamily: "Cairo"),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide(
                                                  width: 0.8,
                                                  color: KPinkColor)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide(
                                                  width: 1, color: KPinkColor)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide(
                                                  width: 1, color: KPinkColor)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 50.0, vertical: 16),
                                      child: MultiSelectFormField(
                                        autovalidate: false,
                                        title: Text(
                                          "المنتجات",
                                          style: TextStyle(
                                              color: KPinkColor,
                                              fontFamily: "Cairo"),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.length == 0) {
                                            return 'برجاء اختيار منتج او اكثر';
                                          }
                                        },

                                        dataSource: list,
                                        textField: 'display',
                                        valueField: 'value',
                                        okButtonLabel: 'تم',
                                        chipLabelStyle:
                                            TextStyle(color: KPurpleColor),
                                        cancelButtonLabel: 'الغاء',
                                        // required: true,
                                        hintWidget: Text("اضف منتج او اكثر"),
                                        onSaved: (value) {
                                          if (value == null) return;
                                          setState(() {
                                            myActivities = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      child: RaisedButton(
                                        child: Text('Save'),
                                        onPressed: _saveForm,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(_myActivitiesResult),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Text("wait.........");
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
