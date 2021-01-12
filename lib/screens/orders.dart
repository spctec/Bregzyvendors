import 'package:bregzy_vendor/constants.dart';
import 'package:bregzy_vendor/models/orders.dart';
import 'package:bregzy_vendor/widgets/custom_order_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bregzy_vendor/services/network.dart';
import 'package:pie_chart/pie_chart.dart';

import 'order_summary.dart';

class OrdersScreen extends StatelessWidget {
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.brown,
    Colors.indigo,
    Colors.yellow,
    Colors.purpleAccent,
  ];

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: getOrdersSummery(),
                builder: (context, snapshot) {
                  var ordersSummery = snapshot.data;
                  return snapshot.hasData
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    child: Container(
                                      child: Text(
                                        "تفاصيل الطلبات ",
                                        style: GoogleFonts.cairo(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(),
                                        ),
                                      ),
                                    ),
                                    alignment: Alignment.topRight,
                                  ),
                                  PieChart(
                                    dataMap: {
                                      "pending": double.parse(
                                          "${ordersSummery['wc-pending']}"),
                                      "completed": double.parse(
                                          "${ordersSummery['wc-completed']}"),
                                      "on-hold": double.parse(
                                          "${ordersSummery['wc-on-hold']}"),
                                      "processing": double.parse(
                                          "${ordersSummery['wc-processing']}"),
                                      "refunded": double.parse(
                                          "${ordersSummery['wc-refunded']}"),
                                      "cancelled": double.parse(
                                          "${ordersSummery['wc-cancelled']}"),
                                      "failed": double.parse(
                                          "${ordersSummery['wc-failed']}"),
                                    },
                                    animationDuration:
                                        Duration(milliseconds: 800),
                                    chartLegendSpacing: 32,
                                    chartRadius:
                                        MediaQuery.of(context).size.width / 3.2,
                                    colorList: colorList,
                                    initialAngleInDegree: 0,
                                    chartType: ChartType.ring,
                                    ringStrokeWidth: 32,
                                    legendOptions: LegendOptions(
                                        showLegendsInRow: false,
                                        legendPosition: LegendPosition.right,
                                        showLegends: true,
                                        legendShape: BoxShape.circle,
                                        legendTextStyle: GoogleFonts.cairo(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600)),
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValueBackground: true,
                                      showChartValues: true,
                                      showChartValuesInPercentage: false,
                                      showChartValuesOutside: false,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : new Center(child: Text(""));
                }),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: getorders(),
                builder: (context, snapshot) {
                  List<Orders> ordersdata = snapshot.data;
                  return snapshot.hasData
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ordersdata.length,
                          itemBuilder: (_, index) {
                            return Card(
                              elevation: 4.0,
                              semanticContainer: true,
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => orders_details(
                                                orders: ordersdata[index],
                                              )));
                                },
                                leading: CustomText(
                                  text: "EGP ${ordersdata[index].total}",
                                  weight: FontWeight.bold,
                                ),
                                title: Text(
                                    "Order #${ordersdata[index].number}\nCustomer ${ordersdata[index].billing.firstName} ${ordersdata[index].billing.firstName}  ",
                                    style: GoogleFonts.cairo(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                subtitle: Text(
                                    "${ordersdata[index].dateCreated}",
                                    style: GoogleFonts.cairo(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                trailing: CustomText(
                                  text: "${ordersdata[index].status}",
                                  color: Colors.green,
                                ),
                              ),
                            );
                          })
                      : new Center(
                          child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                          backgroundColor: KPurpleColor,
                        ));
                }),
          ],
        ),
      ),
    );
  }
}
