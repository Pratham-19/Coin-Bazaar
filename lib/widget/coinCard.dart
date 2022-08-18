import 'dart:math';
// import 'package:coinbank/colors.dart';
import 'package:coinbank/widget/showCoin.dart';
import 'package:flutter/material.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:jovial_svg/jovial_svg.dart';

class CoinCard extends StatelessWidget {
  final String name;
  final String change;
  final String price;
  final String uuid;
  final String iconUrl;
  final String symbol;
  final List<String> sparkline;
  const CoinCard({
    Key? key,
    required this.iconUrl,
    required this.name,
    required this.change,
    required this.price,
    required this.sparkline,
    required this.uuid,
    required this.symbol,
  }) : super(key: key);

  Color? determineColor(change) {
    if (change < 0) {
      return Colors.red;
    }
    return Colors.green;
  }

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
    double height = MediaQuery.of(context).size.height / 895;
    double width = MediaQuery.of(context).size.width / 375;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowCoinDetails(
              change: change,
              iconUrl: iconUrl,
              name: name,
              price: price,
              symbol: symbol,
              uuid: uuid,
              sparkline: sparklineDouble(sparkline),
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Container(
// gradient:

            // color: LBlack,
            height: height * 100,
            width: width * 205,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color.fromARGB(200, 255, 254, 254),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${double.parse(price.toString()).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: (double.parse(change.toString()) < 0)
                            ? Colors.red
                            : Colors.green,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 33,
                      width: 33,
                      child: (iconUrl.toString().endsWith('.svg') ||
                              iconUrl.toString().contains('svg'))
                          ? ScalableImageWidget.fromSISource(
                              si: ScalableImageSource.fromSvgHttpUrl(
                                  Uri.parse(iconUrl)))
                          : Image.network(
                              "${iconUrl}",
                              fit: BoxFit.contain,
                            ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 105,
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      (double.parse(change) < 0)
                          ? '${double.parse(change.toString()).toStringAsFixed(2)}%'
                          : '+${double.parse(change.toString()).toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: (double.parse(change.toString()) < 0)
                            ? Colors.red
                            : Colors.green,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: Sparkline(
                    data: sparklineDouble(sparkline),
                    useCubicSmoothing: true,
                    // lineGradient: ,
                    // lineWidth: ,
                    cubicSmoothingFactor: 0.2,
                    lineColor: (double.parse(change.toString()) < 0)
                        ? Color.fromARGB(255, 243, 98, 88)
                        :
                        // MYellow,
                        Colors.green,
                    fillMode: FillMode.below,
                    fillGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          (double.parse(change.toString()) < 0)
                              ?
                              // DYellow
                              Color.fromARGB(255, 243, 98, 88)
                              :
                              // MYellow,
                              // LYellow,
                              Color.fromARGB(255, 115, 247, 164),
                          Color.fromARGB(255, 255, 255, 255)
                        ]),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
