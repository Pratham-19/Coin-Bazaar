import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coinbank/model/coin-model.dart';

class GetAllCoins {
  List<Coins> allCoins = [];
  List<Coins> allGainerCoins = [];
  List<Coins> allLoserCoins = [];
  List<CoinHistory> allTimeCoins = [];
  // List<CoinHistory> all1DCoins = [];
  // List<CoinHistory> all1WCoins = [];
  // List<CoinHistory> all1YCoins = [];
  // List<CoinHistory> all3YCoins = [];
  // List<CoinHistory> all5YCoins = [];
  List<String> sparklineInString(listSparkline, newlist) {
    listSparkline.forEach((e) {
      newlist.add(e.toString());
    });
    return newlist;
  }

  Future<void> getallCoins() async {
    String url = "https://api.coinranking.com/v2/coins";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "success") {
      jsonData['data']['coins'].forEach((element) {
        List<String> a = [];
        // print(element['sparkline']);
        if (element['name'].toString().length < 17) {
          Coins coin = Coins(
            change: element['change'],
            uuid: element['uuid'],
            symbol: element['symbol'],
            name: element['name'],
            color: element['color'],
            iconUrl: element['iconUrl'],
            marketCap: element['marketCap'],
            price: element['price'],
            listedAt: element['listedAt'],
            tier: element['tier'],
            rank: element['rank'],
            sparkline: sparklineInString(element['sparkline'], a),
            lowVolume: element['lowVolume'],
            coinrankingUrl: element['coinrankingUrl'],
            hVolume: element['hVolume'],
            btcPrice: element['btcPrice'],
          );
          allCoins.add(coin);
        }
      });
    }
  }

  Future<void> getallGainerCoins() async {
    String url = "https://api.coinranking.com/v2/coins?orderDirection=asc";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "success") {
      jsonData['data']['coins'].forEach((element) {
        if (double.parse(element['change']) > 0 &&
            element['name'].toString().length < 20) {
          List<String> a = [];
          Coins coin = Coins(
            change: element['change'],
            uuid: element['uuid'],
            symbol: element['symbol'],
            name: element['name'],
            color: element['color'],
            iconUrl: element['iconUrl'],
            marketCap: element['marketCap'],
            price: element['price'],
            listedAt: element['listedAt'],
            tier: element['tier'],
            rank: element['rank'],
            sparkline: sparklineInString(element['sparkline'], a),
            lowVolume: element['lowVolume'],
            coinrankingUrl: element['coinrankingUrl'],
            hVolume: element['hVolume'],
            btcPrice: element['btcPrice'],
          );
          allGainerCoins.add(coin);
        }
      });
    }
  }

  Future<void> getallLoserCoins() async {
    String url = "https://api.coinranking.com/v2/coins";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "success") {
      jsonData['data']['coins'].forEach((element) {
        if (double.parse(element['change']) < 0 &&
            element['name'].toString().length < 20) {
          List<String> a = [];
          Coins coin = Coins(
            change: element['change'],
            uuid: element['uuid'],
            symbol: element['symbol'],
            name: element['name'],
            color: element['color'],
            iconUrl: element['iconUrl'],
            marketCap: element['marketCap'],
            price: element['price'],
            listedAt: element['listedAt'],
            tier: element['tier'],
            rank: element['rank'],
            sparkline: sparklineInString(element['sparkline'], a),
            lowVolume: element['lowVolume'],
            coinrankingUrl: element['coinrankingUrl'],
            hVolume: element['hVolume'],
            btcPrice: element['btcPrice'],
          );
          allLoserCoins.add(coin);
        }
      });
    }
  }

// Time COINS 1h, 3h, 12h, 24h, 7d, 30d, 3m, 1y, 3y, 5y
  Future<void> getallTimeCoins(time, uuid) async {
    allTimeCoins = [];
    String url =
        "https://api.coinranking.com/v2/coin/${uuid}/history?timePeriod=${time}";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "success") {
      jsonData['data']['history'].forEach((element) {
        if (element['price'] != "") {
          // List<String> a = [];
          CoinHistory coin = CoinHistory(
            price: element['price'].toString(),
            timeStamp: element['timestamp'].toString(),
          );
          allTimeCoins.add(coin);
        }
      });
    }
  }
}

//   Future<void> getallLoserCoins() async {
//     String url = "https://api.coinranking.com/v2/coins";
//     var response = await http.get(Uri.parse(url));
//     var jsonData = jsonDecode(response.body);
//     if (jsonData['status'] == "success") {
//       jsonData['data']['coins'].forEach((element) {
//         if (double.parse(element['change']) < 0 &&
//             element['name'].toString().length < 17) {
//           List<String> a = [];
//           Coins coin = Coins(
//             change: element['change'],
//             uuid: element['uuid'],
//             symbol: element['symbol'],
//             name: element['name'],
//             color: element['color'],
//             iconUrl: element['iconUrl'],
//             marketCap: element['marketCap'],
//             price: element['price'],
//             listedAt: element['listedAt'],
//             tier: element['tier'],
//             rank: element['rank'],
//             sparkline: sparklineInString(element['sparkline'], a),
//             lowVolume: element['lowVolume'],
//             coinrankingUrl: element['coinrankingUrl'],
//             hVolume: element['hVolume'],
//             btcPrice: element['btcPrice'],
//           );
//           allLoserCoins.add(coin);
//         }
//       });
//     }
//   }
// }
//   Future<void> getallLoserCoins() async {
//     String url = "https://api.coinranking.com/v2/coins";
//     var response = await http.get(Uri.parse(url));
//     var jsonData = jsonDecode(response.body);
//     if (jsonData['status'] == "success") {
//       jsonData['data']['coins'].forEach((element) {
//         if (double.parse(element['change']) < 0 &&
//             element['name'].toString().length < 17) {
//           List<String> a = [];
//           Coins coin = Coins(
//             change: element['change'],
//             uuid: element['uuid'],
//             symbol: element['symbol'],
//             name: element['name'],
//             color: element['color'],
//             iconUrl: element['iconUrl'],
//             marketCap: element['marketCap'],
//             price: element['price'],
//             listedAt: element['listedAt'],
//             tier: element['tier'],
//             rank: element['rank'],
//             sparkline: sparklineInString(element['sparkline'], a),
//             lowVolume: element['lowVolume'],
//             coinrankingUrl: element['coinrankingUrl'],
//             hVolume: element['hVolume'],
//             btcPrice: element['btcPrice'],
//           );
//           allLoserCoins.add(coin);
//         }
//       });
//     }
//   }
// }
//   Future<void> getallLoserCoins() async {
//     String url = "https://api.coinranking.com/v2/coins";
//     var response = await http.get(Uri.parse(url));
//     var jsonData = jsonDecode(response.body);
//     if (jsonData['status'] == "success") {
//       jsonData['data']['coins'].forEach((element) {
//         if (double.parse(element['change']) < 0 &&
//             element['name'].toString().length < 17) {
//           List<String> a = [];
//           Coins coin = Coins(
//             change: element['change'],
//             uuid: element['uuid'],
//             symbol: element['symbol'],
//             name: element['name'],
//             color: element['color'],
//             iconUrl: element['iconUrl'],
//             marketCap: element['marketCap'],
//             price: element['price'],
//             listedAt: element['listedAt'],
//             tier: element['tier'],
//             rank: element['rank'],
//             sparkline: sparklineInString(element['sparkline'], a),
//             lowVolume: element['lowVolume'],
//             coinrankingUrl: element['coinrankingUrl'],
//             hVolume: element['hVolume'],
//             btcPrice: element['btcPrice'],
//           );
//           allLoserCoins.add(coin);
//         }
//       });
//     }
//   }
// }
//   Future<void> getallLoserCoins() async {
//     String url = "https://api.coinranking.com/v2/coins";
//     var response = await http.get(Uri.parse(url));
//     var jsonData = jsonDecode(response.body);
//     if (jsonData['status'] == "success") {
//       jsonData['data']['coins'].forEach((element) {
//         if (double.parse(element['change']) < 0 &&
//             element['name'].toString().length < 17) {
//           List<String> a = [];
//           Coins coin = Coins(
//             change: element['change'],
//             uuid: element['uuid'],
//             symbol: element['symbol'],
//             name: element['name'],
//             color: element['color'],
//             iconUrl: element['iconUrl'],
//             marketCap: element['marketCap'],
//             price: element['price'],
//             listedAt: element['listedAt'],
//             tier: element['tier'],
//             rank: element['rank'],
//             sparkline: sparklineInString(element['sparkline'], a),
//             lowVolume: element['lowVolume'],
//             coinrankingUrl: element['coinrankingUrl'],
//             hVolume: element['hVolume'],
//             btcPrice: element['btcPrice'],
//           );
//           allLoserCoins.add(coin);
//         }
//       });
//     }
//   }
// }
//   Future<void> getallLoserCoins() async {
//     String url = "https://api.coinranking.com/v2/coins";
//     var response = await http.get(Uri.parse(url));
//     var jsonData = jsonDecode(response.body);
//     if (jsonData['status'] == "success") {
//       jsonData['data']['coins'].forEach((element) {
//         if (double.parse(element['change']) < 0 &&
//             element['name'].toString().length < 17) {
//           List<String> a = [];
//           Coins coin = Coins(
//             change: element['change'],
//             uuid: element['uuid'],
//             symbol: element['symbol'],
//             name: element['name'],
//             color: element['color'],
//             iconUrl: element['iconUrl'],
//             marketCap: element['marketCap'],
//             price: element['price'],
//             listedAt: element['listedAt'],
//             tier: element['tier'],
//             rank: element['rank'],
//             sparkline: sparklineInString(element['sparkline'], a),
//             lowVolume: element['lowVolume'],
//             coinrankingUrl: element['coinrankingUrl'],
//             hVolume: element['hVolume'],
//             btcPrice: element['btcPrice'],
//           );
//           allLoserCoins.add(coin);
//         }
//       });
//     }
//   }
// }
