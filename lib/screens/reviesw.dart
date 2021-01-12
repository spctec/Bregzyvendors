import 'package:bregzy_vendor/constants.dart';
import 'package:bregzy_vendor/services/network.dart';
import 'package:bregzy_vendor/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewsScreen extends StatelessWidget {
  static String id = 'ReviewsScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Custom_Header(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Divider(
                thickness: 1.8,
              ),
            ),
            FutureBuilder(
              future: getReviewsSummary(),
              builder: (context, snapshot) {
                var reviewSummary = snapshot.data;
                if (snapshot.hasData) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(30.0),
                          elevation: 5.0,
                          child: Container(
                            height: 100.0,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  " اجمالي المراجعات",
                                  style: TextStyle(
                                      color: KPinkColor,
                                      fontFamily: "Cairo",
                                      fontSize: 20.0),
                                ),
                                Text(
                                  " : ",
                                  style: TextStyle(
                                      color: KPurpleColor,
                                      fontFamily: "Cairo",
                                      fontSize: 20.0),
                                ),
                                Text(
                                  "${reviewSummary['comment_counts']['total']}",
                                  style: TextStyle(
                                      color: KPurpleColor,
                                      fontFamily: "Cairo",
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.000,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.heart,
                                          color: Colors.blue,
                                        ),
                                        Text(
                                            "${reviewSummary['comment_counts']['approved']}")
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.angry,
                                          color: Colors.red[700],
                                        ),
                                        Text(
                                            "${reviewSummary['comment_counts']['trash']}")
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50.00,
                          ),
                          child: Divider(
                            thickness: 1.8,
                            color: KPurpleColor,
                          ),
                        ),
                        Text("تفصيل المرجعات",
                            style: TextStyle(
                              color: KPinkColor,
                              fontFamily: "Cairo",
                              fontSize: 30,
                            )),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5569,
                            child: FutureBuilder(
                              future: getReviews(),
                              builder: (context, snapshot) {
                                var reviews = snapshot.data;
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: reviews.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 50.0),
                                            child: Material(
                                              elevation: 5.0,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${reviews[index]['name']}",
                                                              style: TextStyle(
                                                                  color:
                                                                      KPinkColor,
                                                                  fontFamily:
                                                                      "Cairo",
                                                                  fontSize:
                                                                      20.0),
                                                            ),
                                                            Text(
                                                              "${reviews[index]['email']}",
                                                              style: TextStyle(
                                                                color:
                                                                    KPurpleColor,
                                                                fontSize: 8.0,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "${reviews[index]['date_created']}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10.0,
                                                                  color: Colors
                                                                          .grey[
                                                                      500]),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                            "${reviews[index]['review']}")
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SmoothStarRating(
                                                            allowHalfRating:
                                                                false,
                                                            onRated: (v) {},
                                                            starCount: int.parse(
                                                                "${reviews[index]['rating']}"),
                                                            rating: double.parse(
                                                                "${reviews[index]['rating']}"),
                                                            size: 20.0,
                                                            isReadOnly: true,
                                                            color: KOrangeColor,
                                                            spacing: 0.0)
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return Text(
                                    "يرجى الانتظار",
                                    style: TextStyle(
                                      fontFamily: "Cairo",
                                      fontSize: 20.0,
                                      color: KPurpleColor,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: KPinkColor,
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
