import 'package:coinbank/colors.dart';
import 'package:flutter/material.dart';

class Portfolio extends StatelessWidget {
  final double appBarHeight = 66.0;
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return MaterialApp(
      home: Scaffold(
          body: CustomScrollView(
        slivers: <Widget>[
          // ignore: prefer_const_constructors
          SliverAppBar(
            backgroundColor: MBlack,
            snap: false,
            pinned: true,
            floating: false,
            // ignore: prefer_const_constructors
            title: Center(
              child: const Text(
                "Portfolio",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Nunito",
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Container(
                  // decoration: ,
                  padding: EdgeInsets.only(
                    top: statusBarHeight + 70,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  height: statusBarHeight + appBarHeight,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  "Current",
                                  style: TextStyle(
                                      color: DBlack,
                                      fontFamily: "Nunito",
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "\$0",
                                  style: TextStyle(
                                      color: DBlack,
                                      fontFamily: "Nunito",
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Column(
                              children: const [
                                Text(
                                  "Invested",
                                  style: TextStyle(
                                      color: DBlack,
                                      fontFamily: "Nunito",
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "\$0",
                                  style: TextStyle(
                                      color: DBlack,
                                      fontFamily: "Nunito",
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  "Returns",
                                  style: TextStyle(
                                      color: DBlack,
                                      fontFamily: "Nunito",
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "\$0",
                                  style: TextStyle(
                                      color: DBlack,
                                      fontFamily: "Nunito",
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(
                              children: const [
                                Text(
                                  "% Returns",
                                  style: TextStyle(
                                      color: DBlack,
                                      fontFamily: "Nunito",
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "0%",
                                  style: TextStyle(
                                      color: DBlack,
                                      fontFamily: "Nunito",
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            expandedHeight: 340,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                tileColor: (index % 2 == 0) ? Colors.white : Colors.green[50],
                title: Center(
                    child: Column(
                  children: [
                    Image(
                      image:
                          AssetImage("lib/assets/3dStickers/male-investor.png"),
                    ),
                    Text(
                      "Buy more Earn more !",
                      style: TextStyle(
                          color: DBlack,
                          fontFamily: "Nunito",
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
                    // Text('$index',
                    //     style:
                    //     //  TextStyle(
                    //     //     fontWeight: FontWeight.normal,
                    //     //     fontSize: 30,
                    //     //     color: Colors.greenAccent[400]),
                    //         ),
                    ),
              ),
              childCount: 1,
            ),
          )
        ],
      )),
      debugShowCheckedModeBanner: false,
    );
  }
}
