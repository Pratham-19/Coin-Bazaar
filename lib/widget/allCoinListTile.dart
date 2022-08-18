import 'dart:math';

import 'package:coinbank/colors.dart';
import 'package:coinbank/widget/showCoin.dart';
import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';

class CoinCardAll extends StatefulWidget {
  final String name;
  final String symbol;
  final String price;
  final String percent24HChange;
  final String iconUrl;
  final String uuid;
  final List<String> sparkline;
  Color? eyeIconColor = Colors.grey[300];

  CoinCardAll({
    required this.name,
    required this.symbol,
    required this.price,
    required this.percent24HChange,
    required this.uuid,
    required this.iconUrl,
    required this.sparkline,
  });

  @override
  _CoinCardAllState createState() => _CoinCardAllState();
}

class _CoinCardAllState extends State<CoinCardAll> {
  List<double> sparklineDouble(sparklineString) {
    List<double> newList = [];
    sparklineString.forEach((e) {
      if (e == "null") {
        newList.add(Random().nextDouble() * 9999);
      } else {
        newList.add(double.parse(e));
      }
    });
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowCoinDetails(
              change: widget.percent24HChange,
              iconUrl: widget.iconUrl,
              name: widget.name,
              price: widget.price,
              symbol: widget.symbol,
              uuid: widget.uuid,
              sparkline: sparklineDouble(widget.sparkline),
            ),
          ),
        );
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(200, 255, 254, 254)),
              height: 80,
              // color: Color.fromARGB(200, 255, 254, 254),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 10.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: (widget.iconUrl.toString().endsWith('.svg') ||
                              widget.iconUrl.toString().contains('svg'))
                          ? ScalableImageWidget.fromSISource(
                              si: ScalableImageSource.fromSvgHttpUrl(
                                  Uri.parse(widget.iconUrl)))
                          : Image.network(
                              "${widget.iconUrl}",
                              fit: BoxFit.contain,
                            ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          Text(
                            widget.symbol,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold,
                            ),
                            // style: kCoinCodeTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '\$${double.parse(widget.price).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: (widget.percent24HChange[0] != '-')
                              ? Color(0xAAE5FBF0)
                              : Color(0xFFFEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          '${widget.percent24HChange}%',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: (widget.percent24HChange[0] != '-')
                                ? Color(0xFF43BC7A)
                                : Color(0xFFF35957),
                          ),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   flex: 4,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       setState(() {
                    //         widget.eyeIconColor = Color.fromARGB(255, 0, 0, 0);
                    //       });
                    //     },
                    //     onSecondaryTap: () {
                    //       setState(() {
                    //         widget.eyeIconColor = Colors.grey[300];
                    //       });
                    //     },
                    //     child: Icon(
                    //       CupertinoIcons.eye,
                    //       color: widget.eyeIconColor,
                    //       size: 25,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: SizedBox(
                height: 0,
                child: Divider(
                  // height: ,
                  color: kWhite,
                  thickness: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
