class Coins {
  String? uuid;
  String? symbol;
  String? name;
  String? color;
  String? iconUrl;
  String? marketCap;
  String? price;
  int? listedAt;
  int? tier;
  String? change;
  int? rank;
  List<String>? sparkline;
  bool? lowVolume;
  String? coinrankingUrl;
  String? hVolume;
  String? btcPrice;
  // bool watchList;

  Coins({
    required this.uuid,
    required this.symbol,
    required this.name,
    required this.color,
    required this.iconUrl,
    required this.marketCap,
    required this.price,
    required this.listedAt,
    required this.tier,
    required this.change,
    required this.rank,
    required this.sparkline,
    required this.lowVolume,
    required this.coinrankingUrl,
    required this.hVolume,
    required this.btcPrice,
    // this.watchList = false,
  });
}

class CoinHistory {
  String timeStamp;
  String price;
  CoinHistory({
    required this.price,
    required this.timeStamp,
  });
}
