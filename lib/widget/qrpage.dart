import 'package:coinbank/colors.dart';
import 'package:flutter/material.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class ShowQR extends StatelessWidget {
  String amt;
  ShowQR({Key? key, required this.amt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final upiDetails = UPIDetails(
        payeeName: "Coin Bazaar",
        upiID: "8826207307@paytm",
        amount: double.parse(amt),
        transactionNote: "Adding Money to Coinbazaar wallet.");

    return Scaffold(
      backgroundColor: DBlack,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Add money via Qr ",
                style: TextStyle(
                  color: kWhite,
                  fontFamily: "Nunito",
                  fontSize: 27,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Card(
                  color: kWhite,
                  // decoration: BoxDecoration(color: kWhite),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: UPIPaymentQRCode(
                      upiDetails: upiDetails,
                      size: 180,
                    ),
                  )),
              const SizedBox(
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Text(
                  "It will be added in your wallet within few hours ",
                  style: TextStyle(
                    color: kWhite,
                    fontFamily: "Nunito",
                    fontSize: 27,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
