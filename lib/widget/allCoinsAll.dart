import 'package:coinbank/colors.dart';
import 'package:coinbank/model/coin-model.dart';
import 'package:coinbank/model/getcoinsapi.dart';
import 'package:coinbank/widget/allCoinListTile.dart';
import 'package:coinbank/widget/tabBarMenu.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

class ListAllCoins extends StatefulWidget {
  const ListAllCoins({Key? key}) : super(key: key);

  @override
  State<ListAllCoins> createState() => _ListAllCoinsState();
}

class _ListAllCoinsState extends State<ListAllCoins> {
  var _loading;
  List<Coins> allMainCoins = [];
  void getToken() async {
    GetAllCoins allTokenCoins = GetAllCoins();
    await allTokenCoins.getallCoins();
    allMainCoins = allTokenCoins.allCoins;
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
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DBlack,
      body: Column(
        children: [
          TabBarMenu(),
          _loading
              ? const Center(
                  // heightFactor: 89,
                  child: CircularProgressIndicator(
                    color: LYellow,
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    itemCount: allMainCoins.length,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return CoinCardAll(
                        iconUrl: allMainCoins[index].iconUrl!,
                        name: allMainCoins[index].name!,
                        percent24HChange: allMainCoins[index].change!,
                        price: allMainCoins[index].price!,
                        symbol: allMainCoins[index].symbol!,
                        uuid: allMainCoins[index].uuid!,
                        sparkline: allMainCoins[index].sparkline!,
                      );
                    }),
                  ),
                ),
        ],
      ),
    );
  }
}
