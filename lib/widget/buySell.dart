import 'package:coinbank/colors.dart';
import 'package:coinbank/utilities/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

class BuyAndSell extends StatefulWidget {
  bool choice;
  String name;
  String amount;
  final String iconUrl;
  final String symbol;

  BuyAndSell(
      {Key? key,
      required this.choice,
      required this.name,
      required this.amount,
      required this.iconUrl,
      required this.symbol})
      : super(key: key);

  @override
  State<BuyAndSell> createState() => _BuyAndSellState();
}

class _BuyAndSellState extends State<BuyAndSell> {
  final TextEditingController amtController = TextEditingController();

  final TextEditingController coinController = TextEditingController();

  bool emptyText = false;

// true -> buy , false -> sell
  @override
  void dispose() {
    super.dispose();
    amtController.dispose();
    coinController.dispose();
  }

  getCoinAmount(amtcont) {
    coinController.text =
        (double.parse(amtcont) / double.parse(widget.amount)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MBlack,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
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
            Text(
              widget.choice ? "Buy ${widget.name}" : "Sell ${widget.name}",
              style: const TextStyle(
                color: kWhite,
                fontFamily: "Nunito",
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Text(
              widget.choice
                  ? "Estimated Buying Price"
                  : "Estimated Selling Price",
              style: const TextStyle(
                color: kWhite,
                fontFamily: "Nunito",
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "\$ ${double.parse(widget.amount).toStringAsFixed(3)}",
              style: const TextStyle(
                color: kWhite,
                fontFamily: "Nunito",
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.choice
                  ? "How much do you want to buy ?"
                  : "How much do you want to sell ?",
              style: const TextStyle(
                color: kWhite,
                fontFamily: "Nunito",
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      // tex
                      style: const TextStyle(
                        color: DBlack,
                      ),
                      controller: amtController,
                      onChanged: (_) {
                        getCoinAmount(amtController.text);
                      },
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: InputDecoration(
                        errorText:
                            emptyText ? "Amount can\'t be empty !!" : null,
                        isDense: true,
                        hintText: "Enter amount ",
                        hintStyle: const TextStyle(
                            color: kGrey, fontSize: 14, fontFamily: "Nunito"),
                        filled: true,
                        // suffixIcon: suffixIcon,
                        focusColor: LYellow,
                        fillColor: kWhite,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14.0),
                          ),
                          borderSide: BorderSide(
                            color: DYellow,
                            width: 2,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            color: kLightGrey,
                            // width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "=",
                    style: TextStyle(
                      color: kWhite,
                      fontFamily: "Nunito",
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      // tex
                      style: const TextStyle(
                        color: DBlack,
                      ),
                      readOnly: true,
                      controller: coinController,
                      // keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "In ${widget.symbol}",
                        hintStyle: const TextStyle(
                            color: kGrey, fontSize: 14, fontFamily: "Nunito"),
                        filled: true,
                        focusColor: LYellow,
                        fillColor: kWhite,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14.0),
                          ),
                          borderSide: BorderSide(
                            color: DYellow,
                            width: 2,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            color: kLightGrey,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                ),
                // TextField()
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Balance: 0",
                  style: TextStyle(
                    color: kWhite,
                    fontFamily: "Nunito",
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      backgroundColor: DBlack,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: LYellow,
          ),
          child: Text(
            widget.choice ? "Continue to Buy" : "Continue to Sell",
            style: const TextStyle(
              color: DBlack,
              fontSize: 20,
              fontFamily: "Nunito",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
