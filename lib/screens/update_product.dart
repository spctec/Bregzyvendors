import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bregzy_vendor/constants.dart';
import 'package:bregzy_vendor/models/main_categories.dart';
import 'package:bregzy_vendor/models/products.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:bregzy_vendor/services/network.dart';

class Editproducts extends StatefulWidget {
  Map products;

  Editproducts({this.products});

  @override
  _EditproductsState createState() => _EditproductsState();
}

class _EditproductsState extends State<Editproducts> {
  String _error = 'No Error Dectected';
  String _myState;

  final _formKeyeditproduct = GlobalKey<FormState>();
  String productName;
  String stockQuantity;
  String productShortDesc;
  String productPrice;
  String productPricediscount;
  String productDesc;
  bool _isInAsyncCall = false;

  Widget buildGridView() {
    return GridView.builder(
      itemCount: widget.products['images'].length,
      shrinkWrap: true,
      padding: EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          imageUrl: "${widget.products['images'][index]['src']}",
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KPinkColor,
        title: Text(
          "تعديل المنتج",
          style: TextStyle(fontFamily: "Cairo"),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        child: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            strokeWidth: 1.5,
            valueColor: new AlwaysStoppedAnimation<Color>(Color(0xffea1b25)),
          ),
          inAsyncCall: _isInAsyncCall,
          child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 10.0),
              child: Form(
                key: _formKeyeditproduct,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildGridView(),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "اسم المنتج",
                            style: TextStyle(fontFamily: "Cairo"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              onChanged: (value) {
                                productName = value;
                              },
                              initialValue: (widget.products['name'] != null)
                                  ? widget.products['name']
                                  : "",
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        width: 0.8, color: KPinkColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        width: 1, color: KPinkColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        width: 1, color: KPinkColor)),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "سعر المنتج",
                            style: TextStyle(fontFamily: "Cairo"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              onChanged: (value) {
                                productPrice = value;
                              },
                              initialValue:
                                  (widget.products['regular_price'] != null)
                                      ? widget.products['regular_price']
                                      : "",
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        width: 0.8, color: KPinkColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        width: 1, color: KPinkColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        width: 1, color: KPinkColor)),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "سعر بعد الخصم",
                            style: TextStyle(fontFamily: "Cairo"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              onChanged: (value) {
                                productPricediscount = value;
                              },
                              initialValue:
                                  (widget.products['sale_price'] != null)
                                      ? widget.products['sale_price']
                                      : "",
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        width: 0.8, color: KPinkColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        width: 1, color: KPinkColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        width: 1, color: KPinkColor)),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "عدد المنتج",
                            style: TextStyle(fontFamily: "Cairo"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              onChanged: (value) {
                                stockQuantity = value;
                              },
                              initialValue:
                                  (widget.products['stock_quantity'] != null)
                                      ? widget.products['stock_quantity']
                                      : "",
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        width: 0.8, color: KPinkColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        width: 1, color: KPinkColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        width: 1, color: KPinkColor)),
                              ))
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: getMaincategories(),
                        builder: (context, snapshot) {
                          List<categories> maincategories = snapshot.data;
                          return snapshot.hasData
                              ? Container(
                                  height: 150,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 5),
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "أختار من الاقسام",
                                          style: TextStyle(fontFamily: "Cairo"),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: ButtonTheme(
                                                  alignedDropdown: true,
                                                  child: DropdownButton<String>(
                                                    value: _myState,
                                                    iconSize: 30,
                                                    icon: (null),
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 16,
                                                    ),
                                                    hint:
                                                        Text('Select Category'),
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        _myState = newValue;
                                                        print(_myState);
                                                      });
                                                    },
                                                    items: maincategories
                                                            ?.map((item) {
                                                          return new DropdownMenuItem(
                                                            child: new Text(
                                                                item.name),
                                                            value: item.id
                                                                .toString(),
                                                          );
                                                        })?.toList() ??
                                                        [],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : new Center(child: Text(""));
                        }),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "وصف المنتج",
                            style: TextStyle(fontFamily: "Cairo"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              productShortDesc = value;
                            },
                            initialValue:
                                (widget.products['short_description'] != null)
                                    ? widget.products['short_description']
                                    : "",
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            maxLines: 5,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      width: 0.8, color: KPinkColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide:
                                      BorderSide(width: 1, color: KPinkColor)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide:
                                      BorderSide(width: 1, color: KPinkColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "وصف الكامل",
                            style: TextStyle(fontFamily: "Cairo"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              productDesc = value;
                            },
                            initialValue:
                                (widget.products['description'] != null)
                                    ? widget.products['description']
                                    : "",
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            maxLines: 5,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      width: 0.8, color: KPinkColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide:
                                      BorderSide(width: 1, color: KPinkColor)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide:
                                      BorderSide(width: 1, color: KPinkColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _submitButton(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )),
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Future<void> addedAlert() async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.TOPSLIDE,
      padding: EdgeInsets.all(0),
      title: "تأكيد",
      desc: "تم تعديل المنتج بنجاح",
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
      desc: "هناك خطأ فى تعديل المنتج ",
      dismissOnTouchOutside: true,
      headerAnimationLoop: false,
    ).show();
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        _formKeyeditproduct.currentState.save();

        setState(() {
          _isInAsyncCall = true;

          Updateproducts(
            productID: widget.products['id'],
            stockQuantity: (stockQuantity != null)
                ? stockQuantity.hashCode
                : widget.products['stock_quantity'].hashCode,
            categoryId: (_myState != null)
                ? _myState
                : widget.products['categories'][0]['id'],
            productDesc: (productDesc != null)
                ? productDesc
                : widget.products['description'],
            productShortDesc: (productShortDesc != null)
                ? productShortDesc
                : widget.products['short_description'],
            productName:
                (productName != null) ? productName : widget.products['name'],
            productPrice: (productPrice != null)
                ? productPrice
                : widget.products['price'].toString(),
            productPricediscount: (productPricediscount != null)
                ? productPricediscount
                : widget.products['sale_price'].toString(),
          ).whenComplete(() {
            if (status == true) {
              _isInAsyncCall = false;
              Navigator.pop(context);
              addedAlert();
              Navigator.pop(context);
              setState(() {});
            } else if (status == false) {
              _isInAsyncCall = false;
              FiledAlert();
            }
          });
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.symmetric(
          vertical: 15,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: KPurpleColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
        ),
        child: Text(
          'تعديل المنتج',
          style: TextStyle(fontFamily: "Cairo", color: Colors.white),
        ),
      ),
    );
  }
}
