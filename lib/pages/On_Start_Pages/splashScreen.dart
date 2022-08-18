// ignore_for_file: file_names

import 'dart:async';
import 'package:coinbank/colors.dart';
import 'package:coinbank/pages/On_Start_Pages/boardingPage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() async {
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));
  }

  Widget build(BuildContext context) {
    return Material(
      // color: Color(0xFFFFFFFF),
      child: Container(
        // alignment: Alignment(50, 0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF232526),
            Color(0xFF414345),
          ], stops: [
            0.01,
            0.4
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          // gradient: LinearGradient(
          //   colors: [
          //     Color(0xFF232526),
          //     Color(0xFF414345),
          //   ],
          //   begin: Alignment.bottomLeft,
          //   end: Alignment.topRight,
          //   stops: [0.2, 1.8],
          //   // tileMode: TileMode.repeated,
          //   tileMode: TileMode.clamp,
          // ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Align(
                alignment: Alignment.topCenter,
                child: Image(
                  image: AssetImage(
                      "lib/assets/3dStickers/cryptocurrency-wallet-5401600-4521502.png"),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Coin Bazaar",
                style: TextStyle(
                    fontSize: 39,
                    color: kWhite,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Nunito"),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                "The new level of currency",
                style: TextStyle(
                    fontSize: 19,
                    color: kWhite,
                    // fontWeight: FontWeight.bold,
                    fontFamily: "Nunito"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
