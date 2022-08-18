// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinbank/colors.dart';
import 'package:coinbank/model/coin-model.dart';
import 'package:coinbank/model/getcoinsapi.dart';
import 'package:coinbank/widget/buySell.dart';
import 'package:coinbank/widget/graph.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';

class ShowCoinDetails extends StatefulWidget {
  final String name;
  final String change;
  final String price;
  final String iconUrl;
  final String symbol;
  final String uuid;
  final List<double> sparkline;
  const ShowCoinDetails({
    Key? key,
    required this.name,
    required this.change,
    required this.price,
    required this.iconUrl,
    required this.symbol,
    required this.uuid,
    required this.sparkline,
  }) : super(key: key);

  @override
  State<ShowCoinDetails> createState() => _ShowCoinDetailsState();
}

class _ShowCoinDetailsState extends State<ShowCoinDetails> {
  var _loading;

  List<CoinHistory> allTimeCoins = [];

  void getToken(time) async {
    GetAllCoins allTokens = GetAllCoins();
    await allTokens.getallTimeCoins(time, widget.uuid);
    allTimeCoins = allTokens.allTimeCoins;
    setState(
      () {
        _loading = false;
      },
    );
  }

  @override
  void initState() {
    _loading = true;
    super.initState();
    getToken("24h");
  }

  Color changeColor(choice) {
    if (choice) {
      return LYellow;
    }
    return LBlack;
  }

  bool btn1h = false;

  bool btn1d = true;

  bool btn1w = false;

  bool btn1m = false;

  bool btn1y = false;

  bool btnall = false;
  addData() async {
    var db = FirebaseFirestore.instance;

    final user = <String, dynamic>{
      "iconUrl": widget.iconUrl,
      "name": widget.name,
      "change": widget.change,
      "price": widget.price,
      "symbol": widget.symbol,
      "uuid": widget.uuid,
      "sparkline": widget.sparkline,
    };
    await db.collection(userData.displayName.toString()).add(user).then(
        (DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
    setState(() {
      eyeIconColor = LYellow;
    });
  }

  Color? eyeIconColor = Colors.grey[300];
  User get userData => FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DBlack,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              addData();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 14, right: 17),
              child: Column(
                children: [
                  Icon(
                    CupertinoIcons.eye,
                    color: eyeIconColor,
                    size: 20,
                  ),
                  // Icon(Icons.remove_red_eye_outlined),
                  const Text(
                    "Watchlist",
                    style: TextStyle(
                      color: kWhite,
                      fontFamily: "Nunito",
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: DBlack,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: SizedBox(
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
                            // allowDrawingOutsideViewBox: true,
                          ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        color: kWhite,
                        fontFamily: "Nunito",
                        fontSize: 25,
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Text(
                      ' (${widget.symbol})',
                      style: const TextStyle(
                        color: kWhite,
                        fontFamily: "Nunito",
                        fontSize: 25,
                      ),
                      // style: kCoinCodeTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(
                      '\$${double.parse(widget.price).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: kWhite,
                        fontFamily: "Nunito",
                        fontSize: 25,
                      ),
                      // style: kRateTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      (double.parse(widget.change) < 0)
                          ? '▾ ${double.parse(widget.change.toString()).toStringAsFixed(2)}%'
                          : '▴ ${double.parse(widget.change.toString()).toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: (double.parse(widget.change.toString()) < 0)
                            ? Colors.red
                            : Colors.green,
                        fontFamily: "Nunito", fontSize: 25,
                        //color: Color(int.parse("0xff$color").toInt()),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: LYellow,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      color: LBlack,
                      child: SizedBox(
                        height: 200,
                        child: Chart(
                          allTimeCoins: allTimeCoins,
                        ),
                      ),
                    ),
                  ),
            Row(
              children: [
                const SizedBox(
                  width: 9,
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    child: OutlinedButton(
                      onPressed: (() {
                        setState(() {
                          getToken("1h");
                          btn1h = true;
                          btn1d = false;
                          btn1w = false;
                          btn1m = false;
                          btn1y = false;
                          btnall = false;
                          _loading = true;
                        });
                      }),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: changeColor(btn1h),
                      ),
                      child: Text(
                        "1H",
                        style: TextStyle(
                          fontSize: 11.7,
                          fontFamily: "Nunito",
                          color: btn1h ? const Color(0xFF000000) : kWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    child: OutlinedButton(
                      onPressed: (() {
                        setState(() {
                          getToken("24h");
                          btn1h = false;
                          btn1d = true;
                          btn1w = false;
                          btn1m = false;
                          btn1y = false;
                          btnall = false;
                          _loading = true;
                        });
                      }),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: changeColor(btn1d),
                      ),
                      child: Text(
                        "1D",
                        style: TextStyle(
                          fontSize: 11.7,
                          fontFamily: "Nunito",
                          color: btn1d ? const Color(0xFF000000) : kWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    child: OutlinedButton(
                      onPressed: (() {
                        setState(() {
                          getToken("7d");
                          btn1h = false;
                          btn1d = false;
                          btn1w = true;
                          btn1m = false;
                          btn1y = false;
                          btnall = false;
                          _loading = true;
                        });
                      }),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: changeColor(btn1w),
                      ),
                      child: Text(
                        "1W",
                        style: TextStyle(
                          fontSize: 11.7,
                          fontFamily: "Nunito",
                          color: btn1w ? const Color(0xFF000000) : kWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    child: OutlinedButton(
                      onPressed: (() {
                        setState(() {
                          getToken("30d");
                          btn1h = false;
                          btn1d = false;
                          btn1w = false;
                          btn1m = true;
                          btn1y = false;
                          btnall = false;
                          _loading = true;
                        });
                      }),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: changeColor(btn1m),
                      ),
                      child: Text(
                        "1M",
                        style: TextStyle(
                          fontSize: 11.7,
                          fontFamily: "Nunito",
                          color: btn1m ? const Color(0xFF000000) : kWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    child: OutlinedButton(
                      onPressed: (() {
                        setState(() {
                          getToken("1y");
                          btn1h = false;
                          btn1d = false;
                          btn1w = false;
                          btn1m = false;
                          btn1y = true;
                          btnall = false;
                          _loading = true;
                        });
                      }),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: changeColor(btn1y),
                      ),
                      child: Text(
                        "1Y",
                        style: TextStyle(
                          fontSize: 12.7,
                          fontFamily: "Nunito",
                          color: btn1y ? const Color(0xFF000000) : kWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    child: OutlinedButton(
                      onPressed: (() {
                        setState(() {
                          getToken("3y");
                          _loading = true;
                          btn1h = false;
                          btn1d = false;
                          btn1w = false;
                          btn1m = false;
                          btn1y = false;
                          btnall = true;
                        });
                      }),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: changeColor(btnall),
                      ),
                      child: Text(
                        "ALL",
                        style: TextStyle(
                          fontSize: 12.7,
                          fontFamily: "Nunito",
                          color: btnall ? const Color(0xFF000000) : kWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Coin Performance",
                  style: TextStyle(
                      fontSize: 25, fontFamily: "Nunito", color: kWhite),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(9.0),
                  child: Text(
                    "24H High",
                    style: TextStyle(
                      fontSize: 20,
                      color: kWhite,
                      fontFamily: "Nunito",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Text(
                    (widget.sparkline[0] <= widget.sparkline[1])
                        ? (widget.sparkline[0] +
                                (widget.sparkline[1] + widget.sparkline[0]) *
                                    0.1)
                            .toStringAsFixed(2)
                        : widget.sparkline[0].toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 20,
                      color: kWhite,
                      fontFamily: "Nunito",
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
              child: SizedBox(
                child: Divider(
                  // height: ,
                  thickness: 1,
                  color: kWhite,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(9.0),
                  child: Text(
                    "24H Low",
                    style: TextStyle(
                      fontSize: 20,
                      color: kWhite,
                      fontFamily: "Nunito",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Text(
                    widget.sparkline[1].toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 20,
                      color: kWhite,
                      fontFamily: "Nunito",
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
              child: SizedBox(
                child: Divider(
                  // height: ,
                  thickness: 1,
                  color: kWhite,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(9.0),
                  child: Text(
                    "1Y High",
                    style: TextStyle(
                      fontSize: 20,
                      color: kWhite,
                      fontFamily: "Nunito",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Text(
                    (widget.sparkline[2] <= widget.sparkline[3])
                        ? (widget.sparkline[2] +
                                (widget.sparkline[3] + widget.sparkline[0]) *
                                    0.1)
                            .toStringAsFixed(2)
                        : widget.sparkline[2].toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 20,
                      color: kWhite,
                      fontFamily: "Nunito",
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
              child: SizedBox(
                child: Divider(
                  // height: ,
                  thickness: 1,
                  color: kWhite,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(9.0),
                  child: Text(
                    "1Y Low",
                    style: TextStyle(
                      fontSize: 20,
                      color: kWhite,
                      fontFamily: "Nunito",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Text(
                    widget.sparkline[3].toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 20,
                      color: kWhite,
                      fontFamily: "Nunito",
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: SizedBox(
                height: 0,
                child: Divider(
                  // height: ,
                  thickness: 1,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 20,
            child: Container(
              padding: const EdgeInsets.all(6),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BuyAndSell(
                        choice: true,
                        name: widget.name,
                        amount: widget.price,
                        symbol: widget.symbol,
                        iconUrl: widget.iconUrl,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: const Text(
                  "Buy",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 20,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 20,
            child: Container(
              padding: const EdgeInsets.all(6),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BuyAndSell(
                        choice: false,
                        name: widget.name,
                        amount: widget.price,
                        symbol: widget.symbol,
                        iconUrl: widget.iconUrl,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: const Text(
                  "Sell",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 20,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
