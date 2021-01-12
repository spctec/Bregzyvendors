import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:async/async.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imagess;
import 'package:path/path.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bregzy_vendor/constants.dart';
import 'package:bregzy_vendor/models/main_categories.dart';
import 'package:bregzy_vendor/services/network.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewProducts extends StatefulWidget {
  @override
  _AddNewProductsState createState() => _AddNewProductsState();
}

class _AddNewProductsState extends State<AddNewProducts> {
  // ignore: unused_field
  String _error = 'No Error Dectected';
  String _myState;
  TextEditingController productName = new TextEditingController();
  TextEditingController productPrice = new TextEditingController();
  TextEditingController productPricediscount = new TextEditingController();
  TextEditingController productDesc = new TextEditingController();
  TextEditingController productShortDesc = new TextEditingController();
  TextEditingController stockQuantity = new TextEditingController();
  bool _isInAsyncCall = false;
  List images = [null, null, null, null, null];

  List images2 = [null, null, null, null, null];
  List images3 = [null, null, null, null, null];
  List images4 = [null, null, null, null, null];
  List images5 = [null, null, null, null, null];

  List imageLink1 = [null ,null, null ,null , null];
  String imageLink2 = '';
  String imageLink3 = '';
  String imageLink4 = '';
  String imageLink5 = '';


  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    List r;
    String error = 'No Error Dectected';

    try {
      r = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#9A366E",
          statusBarColor: "#9A366E",
          actionBarTitle: "Select Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      print(r[0]);
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      //images = resultList;
      //_error = error;
    });
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.all(8.0),
      crossAxisCount: 5,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 100,
          height: 100,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KPurpleColor,
        title: Text(
          "اضافة منتج جديد",
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   height: 200,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     children: [
                //       Center(
                //         child: (images[0] == null)
                //             ? GestureDetector(
                //                 child: Container(
                //                   height: 150,
                //                   width: 150,
                //                   child: Card(
                //                     color: Colors.grey[300],
                //                     child: Column(
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       crossAxisAlignment: CrossAxisAlignment.center,
                //                       children: [
                //                         Icon(Icons.add),
                //                         Text(
                //                           "أضافة صورة للمنتج",
                //                           style: TextStyle(fontFamily: "Cairo"),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //                 onTap: () async {
                //                   getimage(0);
                //
                //                 },
                //               )
                //             : Container(height:150,width:150,child: Image.file(images[0])),
                //       ),
                //       Center(
                //         child: (images2[0] == null)
                //             ? GestureDetector(
                //           child: Container(
                //             height: 150,
                //             width: 150,
                //             child: Card(
                //               color: Colors.grey[300],
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: [
                //                   Icon(Icons.add),
                //                   Text(
                //                     "أضافة صورة للمنتج",
                //                     style: TextStyle(fontFamily: "Cairo"),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           onTap: () async {
                //             getimage2(0);
                //
                //           },
                //         )
                //             : Container(height: 150, width:150,child: Image.file(images2[0])),
                //       ),
                //       Center(
                //         child: (images3[0] == null)
                //             ? GestureDetector(
                //           child: Container(
                //             height: 150,
                //             width: 150,
                //             child: Card(
                //               color: Colors.grey[300],
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: [
                //                   Icon(Icons.add),
                //                   Text(
                //                     "أضافة صورة للمنتج",
                //                     style: TextStyle(fontFamily: "Cairo"),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           onTap: () async {
                //             getimage3(0);
                //
                //           },
                //         )
                //             : Container(width:150 ,height: 150,child: Image.file(images3[0])),
                //       ),
                //       Center(
                //         child: (images4[0] == null)
                //             ? GestureDetector(
                //           child: Container(
                //             height: 150,
                //             width: 150,
                //             child: Card(
                //               color: Colors.grey[300],
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: [
                //                   Icon(Icons.add),
                //                   Text(
                //                     "أضافة صورة للمنتج",
                //                     style: TextStyle(fontFamily: "Cairo"),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           onTap: () async {
                //             getimage4(0);
                //
                //           },
                //         )
                //             : Container(width:150,height:150,child: Image.file(images4[0])),
                //       ),
                //       Center(
                //         child: (images5[0] == null)
                //             ? GestureDetector(
                //           child: Container(
                //             height: 150,
                //             width: 150,
                //             child: Card(
                //               color: Colors.grey[300],
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: [
                //                   Icon(Icons.add),
                //                   Text(
                //                     "أضافة صورة للمنتج",
                //                     style: TextStyle(fontFamily: "Cairo"),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           onTap: () async {
                //             getimage5(0);
                //
                //           },
                //         )
                //             : Container(width:150,height:150,child: Image.file(images5[0])),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Center(
                        child: (images[index] == null)
                            ? GestureDetector(
                          child: Container(
                            height: 150,
                            width: 150,
                            child: Card(
                              color: Colors.grey[300],
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  Text(
                                    "أضافة صورة للمنتج",
                                    style: TextStyle(fontFamily: "Cairo"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () async {
                            getimage(index);
                          },
                        )
                            : Padding(
                            padding: EdgeInsets.all(10),
                            child: Card(
                                child: Stack(
                                  children: [
                                    Image.file(images[index]),
                                    Positioned(
                                        child: Center(
                                            child: (images[index] != null &&
                                                imageLink1[index] == null)
                                                ? CircularProgressIndicator()
                                                : Container()))
                                  ],
                                ))),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                      TextField(
                        controller: productName,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 0.8, color: KPinkColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 1, color: KPinkColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 1, color: KPinkColor)),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                      TextField(
                        controller: productPrice,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 0.8, color: KPinkColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 1, color: KPinkColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 1, color: KPinkColor)),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                      TextField(
                        controller: productPricediscount,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 0.8, color: KPinkColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 1, color: KPinkColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 1, color: KPinkColor)),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                      TextField(
                        controller: stockQuantity,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 0.8, color: KPinkColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 1, color: KPinkColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 1, color: KPinkColor)),
                        ),
                      )
                    ],
                  ),
                ),
                FutureBuilder(
                    future: getMaincategories(),
                    builder: (context, snapshot) {
                      List<categories> maincategories = snapshot.data;
                      return snapshot.hasData
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 23.0),
                              child: Container(
                                height: 150,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: KPurpleColor),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 5),
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
                                            child: DropdownButtonHideUnderline(
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
                                                  hint: Text('Select Category'),
                                                  onChanged: (String newValue) {
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
                              ),
                            )
                          : new Center(child: Text(""));
                    }),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                      TextField(
                        controller: productShortDesc,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "أدخل بعض الوصف المختصر حول هذا المنتج ...",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 0.8, color: KPinkColor)),
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
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        " وصف المنتج كامل",
                        style: TextStyle(fontFamily: "Cairo"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: productDesc,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        maxLines: 9,
                        decoration: InputDecoration(
                          hintText: "أدخل الوصف الكامل حول هذا المنتج ...",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 0.8, color: KPinkColor)),
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
          ),
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Future<void> addedAlert() async {
    await AwesomeDialog(
      autoHide: Duration(seconds: 2),

      context: super.context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.TOPSLIDE,
      padding: EdgeInsets.all(0),
      title: "تأكيد",
      desc: "تم اضافة المنتج بنجاح",
      dismissOnTouchOutside: true,
      headerAnimationLoop: false,
    ).show();
  }

  Future<void> FiledAlert() async {
    await AwesomeDialog(
      autoHide: Duration(milliseconds: 200),
      context: super.context,
      dialogType: DialogType.ERROR,
      animType: AnimType.TOPSLIDE,
      padding: EdgeInsets.all(0),
      title: "خطأ",
      desc: "هناك خطأ فى المنتج ",
      dismissOnTouchOutside: true,
      headerAnimationLoop: false,
    ).show();
  }
  Widget _submitButton() {
    return GestureDetector(
      onTap: () async {
        if (_myState != null &&
            productDesc.text != null &&
            productShortDesc.text != null &&
            productPrice.text != null &&
            isok()) {
          setState(() {
            _isInAsyncCall = true;
          });
          await addNewProduct(
              images: imageLink1,
              categoryId: _myState,
              productDesc: productDesc.text,
              productShortDesc: productShortDesc.text,
              productName: productName.text,
              productPrice: productPrice.text,
              productPricediscount: productPricediscount.text,
              stockQuantity: int.parse(stockQuantity.text))
              .whenComplete(() {
            Navigator.pop(super.context);
            addedAlert();
            setState(() {
              _isInAsyncCall = false;
            });
          });
        }
      },
      child: Container(
        width: MediaQuery.of(super.context).size.width * 0.5,
        padding: EdgeInsets.symmetric(
          vertical: 15,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xffea1b25),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
        ),
        child: Text(
          'إضافة منتج',
          style: TextStyle(fontFamily: "Cairo"),
        ),
      ),
    );
  }
  // Widget _submitButton() {
  //   return GestureDetector(
  //     onTap: () async {
  //       print("*////////////${imageLink1}");
  //       if(_myState!=null&& productDesc.text!=null&&productShortDesc.text!=null&&productPrice.text!=null){
  //         setState(() {
  //           _isInAsyncCall = true;
  //         });
  //         await addNewProduct(
  //             image: imageLink1[0],
  //             image2: imageLink2,
  //             image3: imageLink3,
  //             image4: imageLink4,
  //             image5: imageLink5,
  //             categoryId: _myState,
  //             productDesc: productDesc.text,
  //             productShortDesc: productShortDesc.text,
  //             productName: productName.text,
  //             productPrice: productPrice.text,
  //             productPricediscount: productPricediscount.text,
  //             stockQuantity: int.parse(stockQuantity.text))
  //             .whenComplete(() {
  //           Navigator.pop(super.context);
  //           addedAlert();
  //           setState(() {
  //             _isInAsyncCall = false;
  //           });
  //         });
  //       }
  //
  //     },
  //     child: Container(
  //       width: MediaQuery.of(super.context).size.width * 0.5,
  //       padding: EdgeInsets.symmetric(
  //         vertical: 15,
  //       ),
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         color: Color(0xffea1b25),
  //         borderRadius: BorderRadius.all(Radius.circular(5)),
  //         boxShadow: <BoxShadow>[
  //           BoxShadow(
  //               color: Colors.grey.shade200,
  //               offset: Offset(2, 4),
  //               blurRadius: 5,
  //               spreadRadius: 2)
  //         ],
  //       ),
  //       child: Text(
  //         'إضافة منتج',
  //         style: TextStyle(fontFamily: "Cairo"),
  //       ),
  //     ),
  //   );
  // }

  //
  Future getimage(int i) async {
    File tempimage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      images[i] = tempimage;
      for (var x in images) {
        print((x == null) ? 'mohab' : x.path);
      }
      setState(() {});
    });
    await uploads(tempimage, i);
  }

  bool isok() {
    int y = 0;
    for (var x in images) {
      if (x == null) {
        y++;
      }
      if (y == 5) {
        return false;
      }
    }
    bool ok = true;
    int d = 0;
    for (var x in images) {
      if (x != null && imageLink1[d] == null) {
        return false;
      }
    }
    return ok;
  }

  Future uploads(File f, int index) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? null;
    var uri = Uri.parse("https://bregzy.com/wp-json/wp/v2/media");
    List z = f.path.split('.');
    setState(() {});
    print(z[z.length - 1]);

    var request = http.MultipartRequest('POST', uri);
    request.fields['status'] = 'publish';
    request.headers.addAll(
        {'Accept': 'application/json', 'Authorization': 'Bearer $value'});

    request.files.add(
      http.MultipartFile(
        'file',
        http.ByteStream(DelegatingStream.typed(f.openRead())),
        await f.length(),
        filename: basename(f.path),
      ),
    );

    print('ok');
    await request.send().then((value) {
      if (value.statusCode == 201) {
        print("Uploaded!");
        value.stream.transform(utf8.decoder).listen((value) async {
          imageLink1[index] = getlink(value);

          setState(() {});
        });
      }
    });
  }

  String getlink(String value) {
    List m = value.split('"guid":{"rendered":"');
    List d = m[1].split('","raw":');
    return d[0];
  }

  getmylink(String x) {
    RegExp exp =
    new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> matches = exp.allMatches(x);

    matches.forEach((match) {
      return x.substring(match.start, match.end);
    });
  }
}
