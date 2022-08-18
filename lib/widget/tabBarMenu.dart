import 'package:coinbank/colors.dart';
import 'package:flutter/material.dart';

class TabBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          color: DBlack,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 30,
                  child: Container(
                    child: Text(
                      'COIN NAME',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        color: kWhite,
                        fontSize: screenHeight * 0.017,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Text(
                    'PRICE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Nunito",
                      color: kWhite,
                      fontSize: screenHeight * 0.017,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 25,
                  child: Text(
                    '24H CHANGE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Nunito",
                      color: kWhite,
                      fontSize: screenHeight * 0.017,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
          child: SizedBox(
            height: 0,
            child: Divider(
              color: kWhite,
              // height: ,
              thickness: 1,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
