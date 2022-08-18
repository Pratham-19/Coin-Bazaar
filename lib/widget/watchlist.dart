import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinbank/colors.dart';
// import 'package:coinbank/model/coin-model.dart';
import 'package:coinbank/widget/allCoinListTile.dart';
import 'package:coinbank/widget/tabBarMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListAllWidgetCoins extends StatefulWidget {
  const ListAllWidgetCoins({Key? key}) : super(key: key);

  @override
  State<ListAllWidgetCoins> createState() => _ListAllCoinsState();
}

class _ListAllCoinsState extends State<ListAllWidgetCoins> {
  var _loading;
  User get userData => FirebaseAuth.instance.currentUser!;
  var allWatchCoin = [];
  var db = FirebaseFirestore.instance;
  // final Stream<QuerySnapshot> _usersStream =
  //     FirebaseFirestore.instance.collection(userData.displayName.toString()).snapshots();
  @override
  void initState() {
    // print("i");
    _loading = true;
    super.initState();
    getWatchlist();
    print(allWatchCoin.length);
  }

  getWatchlist() async {
    allWatchCoin = [];
    await db
        .collection(userData.displayName.toString())
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        allWatchCoin.add(doc.data());
      }
    });
    setState(
      () {
        _loading = false;
      },
    );
  }

  List<String> sparklineDouble(sparklineString) {
    List<String> newList = [];
    sparklineString.forEach((e) {
      if (e == "null") {
        newList.add((Random().nextDouble() * 9999).toString());
      } else {
        newList.add((e).toString());
      }
    });
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DBlack,
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                color: LYellow,
              ),
            )
          : Column(
              children: [
                TabBarMenu(),
                Expanded(
                  child: (allWatchCoin.isEmpty)
                      ? const Center(
                          child: Image(
                            image: AssetImage(
                                "lib/assets/3dStickers/no-results.png"),
                            fit: BoxFit.contain,
                          ),
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          itemCount: allWatchCoin.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return CoinCardAll(
                              iconUrl: allWatchCoin[index]['iconUrl'],
                              name: allWatchCoin[index]['name'],
                              percent24HChange: allWatchCoin[index]['change'],
                              price: allWatchCoin[index]['price'],
                              symbol: allWatchCoin[index]['symbol'],
                              uuid: allWatchCoin[index]['uuid'],
                              sparkline: sparklineDouble(
                                  allWatchCoin[index]['sparkline']),
                            );
                          }),
                        ),
                ),
              ],
            ),
    );
  }
}

// class _UserInformationState extends State<UserInformation> {
//   final Stream<QuerySnapshot> _usersStream =
//       FirebaseFirestore.instance.collection('users').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return
// StreamBuilder<QuerySnapshot>(
//       stream: _usersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return const Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Text("Loading");
//         }

//         return ListView(
//           children: snapshot.data!.docs
//               .map((DocumentSnapshot document) {
//                 Map<String, dynamic> data =
//                     document.data()! as Map<String, dynamic>;
//                 return ListTile(
//                   title: Text(data['full_name']),
//                   subtitle: Text(data['company']),
//                 );
//               })
//               .toList()
//               .cast(),
//         );
//       },
//     );
//   }
// }
