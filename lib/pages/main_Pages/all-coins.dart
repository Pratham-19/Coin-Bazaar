// import 'package:coin_eye/utilities/field_banner.dart';
// import 'package:flutter/cupertino.dart';
import 'package:coinbank/colors.dart';
import 'package:coinbank/widget/allCoinsAll.dart';
// import 'package:coinbank/widget/tabBarMenu.dart';
import 'package:coinbank/widget/watchlist.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import '../services/coin_data.dart';
class AllCoins extends StatefulWidget {
  @override
  _AllCoinsState createState() => _AllCoinsState();
}

class _AllCoinsState extends State<AllCoins> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MBlack,
          toolbarHeight: screenHeight * 0.1,
          elevation: 7,
          title: const Text(
            'Prices',
            style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "My Watchlist",
              ),
              Tab(
                text: "All Coins",
              ),
            ],
            indicatorColor: LYellow,
            // labelColor: LYellow,
            labelStyle: TextStyle(
                fontFamily: "Nunito",
                fontSize: 15,
                fontWeight: FontWeight.w700),
            unselectedLabelColor: kWhite,
            labelColor: LYellow,
          ),
        ),
        body: TabBarView(
          children: [
            ListAllWidgetCoins(),
            ListAllCoins(),
          ],
        ),
      ),
    );
  }
}

//   late TabController _tabController;
//   // late Widget allCoinsTab;
//   // var coinsData;
//   // CoinData coinData;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
//     // allCoinsTab = Center(
//     //   child: SpinKitRing(
//     //     color: Colors.black,
//     //     size: 30,
//     //     lineWidth: 4,
//     //   ),
//     // );
//   }

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: screenHeight * 0.1,
//         elevation: 7,
//         shadowColor: Colors.black,
//         title: const Text("Prices"),
//         bottom: TabBar(
//           overlayColor: MaterialStateProperty.all(Colors.transparent),
//           indicatorColor: Color(0xFF2BFFF1),
//           controller: _tabController,
//           tabs: [
//             Tab(
//               child: Text(
//                 'My Watchlist',
//                 style: TextStyle(
//                     color: Colors.white, fontSize: screenHeight * 0.018),
//               ),
//             ),
//             Tab(
//               child: Text(
//                 'All Coins',
//                 style: TextStyle(
//                     color: Colors.white, fontSize: screenHeight * 0.018),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           // allCoinsTab,
//           Column(
//             children: [
//               Center(
//                 child: Container(
//                   margin: EdgeInsets.all(50),
//                   child: Text(
//                     'You have not added any coin to your watchlist.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.grey.shade700),
//                   ),
//                 ),
//               ),
//               TabBarMenu(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
