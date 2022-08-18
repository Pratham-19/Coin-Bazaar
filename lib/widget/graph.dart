import 'dart:math';
import 'package:coinbank/colors.dart';
import 'package:coinbank/model/coin-model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Chart extends StatelessWidget {
  List<CoinHistory> allTimeCoins;
  Chart({
    Key? key,
    required this.allTimeCoins,
  }) : super(key: key);

  List<num> GrahDataDouble(ChartDataString) {
    List<num> newList = [];
    int i = 0;
    ChartDataString.forEach((e) {
      if (e.price.toString() == "null" || e.price.length == 0) {
        newList.add(i == 0 ? Random().nextDouble() : newList[--i]);
      } else {
        newList.add(double.parse(e.price));
      }
      i++;
    });
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SfSparkLineChart(
        // axisLineColor: kWhite,
        width: 1,
        color: LYellow,
        axisLineWidth: 0,
        trackball: SparkChartTrackball(
          color: kWhite,
          activationMode: SparkChartActivationMode.tap,
          dashArray: [5, 3],
        ),
        data: GrahDataDouble(allTimeCoins.reversed),
      ),
    );
  }
}
