// import 'dart:convert';
// import 'dart:math';
// import 'package:coinbank/model/coin-model.dart';
// import 'package:http/http.dart' as http;

// class CoinPerformance {
//   var allTimeCoins;
//   List<num> GrahDataDouble(ChartDataString) {
//     List<num> newList = [];
//     int i = 0;
//     ChartDataString.forEach((e) {
//       if (e.price.toString() == "null" || e.price.length == 0) {
//         newList.add(i == 0 ? Random().nextDouble() : newList[--i]);
//       } else {
//         newList.add(double.parse(e.price));
//       }
//       i++;
//     });
//     return newList;
//   }

//   Future<void> getallTimeCoins(time, uuid) async {
//     allTimeCoins = [];
//     String url =
//         "https://api.coinranking.com/v2/coin/${uuid}/history?timePeriod=${time}";
//     var response = await http.get(Uri.parse(url));
//     var jsonData = jsonDecode(response.body);
//     if (jsonData['status'] == "success") {
//       jsonData['data']['history'].forEach((element) {
//         if (element['price'] != "") {
//           // List<String> a = [];
//           CoinHistory coin = CoinHistory(
//             price: element['price'].toString(),
//             timeStamp: element['timestamp'].toString(),
//           );
//           allTimeCoins.add(coin);
//         }
//       });
//     }
//   }
//   List<> getMinMax(uuid,time){
//     getallTimeCoins(time,uuid);
//     allTimeCoins=GrahDataDouble(allTimeCoins);

//   }
// }
