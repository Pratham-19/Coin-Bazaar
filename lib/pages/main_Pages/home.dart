import 'package:coinbank/model/coin-model.dart';
import 'package:coinbank/model/getcoinsapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coinbank/widget/coinCard.dart';
import 'package:coinbank/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _loading;
  List<Coins> allApiCoins = [];
  List<Coins> allApiGainerCoins = [];
  List<Coins> allApiLoserCoins = [];
  void getToken() async {
    GetAllCoins allTokens = GetAllCoins();
    await allTokens.getallCoins();
    await allTokens.getallGainerCoins();
    await allTokens.getallLoserCoins();
    allApiCoins = allTokens.allCoins;
    allApiGainerCoins = allTokens.allGainerCoins;
    allApiLoserCoins = allTokens.allLoserCoins;
    setState(
      () {
        _loading = false;
      },
    );
  }

  @override
  void initState() {
    // print("i");
    _loading = true;
    super.initState();
    getToken();
  }

  User get user => FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: DBlack,
      //   elevation: 0,
      //   title: Padding(
      //     padding: const EdgeInsets.only(top: 10, left: 5),
      //     child: Column(
      //       children: [
      //         Text(
      //           "Hi ${user.displayName.toString().substring(0, 1).toUpperCase() + user.displayName.toString().substring(1)} , ",
      //           style: TextStyle(
      //               fontFamily: "Nunito", fontSize: 26, color: kWhite),
      //         ),
      //         Text(
      //           "To Begin with...",
      //           style: TextStyle(
      //               fontFamily: "Nunito", fontSize: 46, color: kWhite),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      backgroundColor: DBlack,
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                color: LYellow,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: Text(
                        "Hi ${user.displayName.toString().substring(0, 1).toUpperCase() + user.displayName.toString().substring(1)} , ",
                        style: const TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 30,
                            color: kWhite,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Text(
                        "Lets begin with...",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 32,
                            color: kWhite,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Top Coins",
                            style: TextStyle(
                                color: kWhite,
                                fontFamily: "Nunito",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            "Watch whats trending..",
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 16,
                              fontFamily: "Nunito",
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemCount: allApiCoins.length
                              // allcoins.data!.data!.coins!.length,
                              ,
                              shrinkWrap: true,
                              // padding: EdgeInsets.all(8),
                              itemBuilder: ((context, index) {
                                return CoinCard(
                                  iconUrl: allApiCoins[index].iconUrl!,
                                  name: allApiCoins[index].name!,
                                  change: allApiCoins[index].change!,
                                  price: allApiCoins[index].price!,
                                  sparkline: allApiCoins[index].sparkline!,
                                  symbol: allApiCoins[index].symbol!,
                                  uuid: allApiCoins[index].uuid!,
                                );
                              }),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Top Gainer",
                            style: TextStyle(
                                color: kWhite,
                                fontSize: 20,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            "Coins that have gained the most in 24hr",
                            style: TextStyle(
                              color: kWhite,
                              fontFamily: "Nunito",
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 150,
                            // width: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemCount: allApiGainerCoins.length
                              // allcoins.data!.data!.coins!.length,
                              ,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                return CoinCard(
                                  iconUrl: allApiGainerCoins[index].iconUrl!,
                                  name: allApiGainerCoins[index].name!,
                                  // allcoins.data!.data!.coins![index].name,
                                  change: allApiGainerCoins[index].change!,
                                  // allcoins.data!.data!.coins![index].change,
                                  price: allApiGainerCoins[index].price!,
                                  sparkline:
                                      allApiGainerCoins[index].sparkline!,
                                  symbol: allApiGainerCoins[index].symbol!,
                                  uuid: allApiGainerCoins[index].uuid!,
                                  // allcoins.data!.data!.coins![index].price,
                                );
                              }),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Top Loser",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                color: kWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          const Text(
                            "Coins that have corrected the most in 24hr",
                            style: TextStyle(
                              fontFamily: "Nunito",
                              color: kWhite,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 150,
                            // width: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemCount: allApiLoserCoins.length
                              // allcoins.data!.data!.coins!.length,
                              ,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                return CoinCard(
                                  iconUrl: allApiLoserCoins[index].iconUrl!,
                                  name: allApiLoserCoins[index].name!,
                                  // allcoins.data!.data!.coins![index].name,
                                  change: allApiLoserCoins[index].change!,
                                  // allcoins.data!.data!.coins![index].change,
                                  price: allApiLoserCoins[index].price!,
                                  sparkline: allApiLoserCoins[index].sparkline!,
                                  symbol: allApiLoserCoins[index].symbol!,
                                  uuid: allApiLoserCoins[index].uuid!,
                                  // allcoins.data!.data!.coins![index].price,
                                );
                              }),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       context.read<FirebaseAuthMethods>().signOut(context);
                    //       Navigator.pushNamedAndRemoveUntil(
                    //           context, AppRoutes.signInScreenRoute, (route) => false);
                    //     },
                    //     child: const Text("Sign out")),
                    // SizedBox(
                    //   height: 200,
                    // )
                  ],
                ),
              ),
            ),
    );
  }
}
