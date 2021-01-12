import 'package:bregzy_vendor/constants.dart';
import 'package:bregzy_vendor/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class orders_details extends StatefulWidget {
  Orders orders;

  orders_details({this.orders});

  @override
  _orders_detailsState createState() => _orders_detailsState();
}

class _orders_detailsState extends State<orders_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: KPurpleColor,
        centerTitle: true,
        title: Text(
          "الطلبات",
          style: TextStyle(fontFamily: "Cairo"),
        ),
      ),
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 8.0,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "تفاصيل عامة",
                              style: GoogleFonts.cairo(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(),
                              ),
                            ),
                          ),
                          Text(" حالة الطلب: ${widget.orders.status}",
                              style: TextStyle(fontFamily: "Cairo")),
                          Text("${widget.orders.dateCompleted}",
                              style: TextStyle(fontFamily: "Cairo")),
                          Divider(),
                          // Text(
                          //     " اسم العميل: ${widget.orders.billing.firstName} ${widget.orders.billing.lastName}",
                          //     style: TextStyle(fontFamily: "Cairo")),
                          // Text(
                          //     "البريد الالكترونى :${widget.orders.billing.email}",
                          //     style: TextStyle(fontFamily: "Cairo")),
                          // Text("هاتف :${widget.orders.billing.phone}",
                          //     style: TextStyle(fontFamily: "Cairo")),
                          Text("IP العميل : ${widget.orders.customerIpAddress}",
                              style: TextStyle(fontFamily: "Cairo")),
                          (widget.orders.customerNote != "")
                              ? Container(
                                  child: Text(
                                    "ملحوظة العميل",
                                    style: GoogleFonts.cairo(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(),
                                    ),
                                  ),
                                )
                              : Text(""),
                          (widget.orders.customerNote != "")
                              ? Text("- ${widget.orders.customerNote}",
                                  style: TextStyle(fontFamily: "Cairo"))
                              : Text(""),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 8.0,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "طلب رقم ${widget.orders.number}  ← عناصر الطلب ",
                              style: GoogleFonts.cairo(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(),
                              ),
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.orders.lineItems.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 4,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: KPurpleColor,
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: FittedBox(
                                            child: Text(
                                              'EGP ${widget.orders.lineItems[index].price}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        widget.orders.lineItems[index].name,
                                        style: TextStyle(fontFamily: "Cairo"),
                                      ),
                                      subtitle: Text(
                                          "الاجمالى  :  EGP${widget.orders.lineItems[index].total}",
                                          style:
                                              TextStyle(fontFamily: "Cairo")),
                                      trailing: Text(
                                          '${widget.orders.lineItems[index].quantity} x'),
                                    ),
                                  ),
                                );
                              }),
                          Text(
                            "الشحن:	    EGP ${widget.orders.shippingTotal}",
                            style: TextStyle(fontFamily: "Cairo"),
                          ),
                          Divider(),
                          Text(
                            "وسيلة الدفع:	${widget.orders.paymentMethodTitle}",
                            style: TextStyle(fontFamily: "Cairo"),
                          ),
                          Divider(),
                          Text("الاجمالى :	EGP ${widget.orders.total}",
                              style: TextStyle(fontFamily: "Cairo")),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     child: Card(
              //       elevation: 8.0,
              //       child: Padding(
              //         padding: EdgeInsets.all(10.0),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Container(
              //               child: Text(
              //                 "عنوان وصول الفواتير",
              //                 style: GoogleFonts.cairo(
              //                     fontSize: 16, fontWeight: FontWeight.bold),
              //               ),
              //               decoration: BoxDecoration(
              //                 border: Border(
              //                   bottom: BorderSide(),
              //                 ),
              //               ),
              //             ),
              //             Text(
              //                 " اسم العميل :${widget.orders.billing.firstName} ${widget.orders.billing.lastName}",
              //                 style: TextStyle(fontFamily: "Cairo")),
              //             Text(" العنوان :${widget.orders.billing.address1}",
              //                 style: TextStyle(fontFamily: "Cairo")),
              //             Text(" المدينة: ${widget.orders.billing.city}",
              //                 style: TextStyle(fontFamily: "Cairo")),
              //             Text("االدوله :${widget.orders.billing.state}",
              //                 style: TextStyle(fontFamily: "Cairo")),
              //             Text("رقم الهاتف :${widget.orders.billing.phone}",
              //                 style: TextStyle(fontFamily: "Cairo")),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     child: Card(
              //       elevation: 8.0,
              //       child: Padding(
              //         padding: EdgeInsets.all(10.0),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Container(
              //               child: Text(
              //                 "عنوان الشحن",
              //                 style: GoogleFonts.cairo(
              //                     fontSize: 16, fontWeight: FontWeight.bold),
              //               ),
              //               decoration: BoxDecoration(
              //                 border: Border(
              //                   bottom: BorderSide(),
              //                 ),
              //               ),
              //             ),
              //             Text(
              //                 " اسم العميل :${widget.orders.shipping.firstName} ${widget.orders.shipping.lastName}",
              //                 style: TextStyle(fontFamily: "Cairo")),
              //             Text(" العنوان :${widget.orders.shipping.address1}",
              //                 style: TextStyle(fontFamily: "Cairo")),
              //             Text(" المدينة: ${widget.orders.shipping.city}",
              //                 style: TextStyle(fontFamily: "Cairo")),
              //             Text("االدوله :${widget.orders.shipping.state}",
              //                 style: TextStyle(fontFamily: "Cairo")),
              //             Text("رقم الهاتف :${widget.orders.shipping.phone}",
              //                 style: TextStyle(fontFamily: "Cairo")),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
