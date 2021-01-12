import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class report_widget extends StatelessWidget {
  final Color iconBackground;
  final FaIcon icon;
  final String reportType;
  final Color reportTypeColor;
  final bool precientage;

  const report_widget(
      {Key key,
      this.icon,
      this.reportType,
      this.precientage,
      this.iconBackground,
      this.reportTypeColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.4,
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        precientage
                            ? Icon(
                                Icons.arrow_upward_rounded,
                                color: Colors.green,
                                size: 17,
                              )
                            : SizedBox(
                                width: 0.1,
                              ),
                        precientage
                            ? AutoSizeText(
                                "+10%",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                                maxLines: 1,
                              )
                            : SizedBox(
                                width: 15,
                              ),
                      ],
                    ),
                    CircleAvatar(
                      child: icon,
                      backgroundColor: iconBackground,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      "L.E",
                      style: TextStyle(fontSize: 12),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      "125.36",
                      style: TextStyle(fontSize: 20.0),
                      maxLines: 1,
                      minFontSize: 10,
                      stepGranularity: 10,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AutoSizeText(
                          reportType,
                          style: TextStyle(
                              fontFamily: "Cairo", color: reportTypeColor),
                          maxLines: 1,
                          minFontSize: 10,
                          stepGranularity: 10,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
