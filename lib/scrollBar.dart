import 'package:coinbank/colors.dart';
import 'package:coinbank/pages/main_Pages/all-coins.dart';
// import 'package:flutter/cupertino.dart';

import 'pages/main_Pages/all-coins.dart';
import 'pages/main_Pages/profile.dart';
import 'pages/main_Pages/investment.dart';
import 'pages/main_Pages/home.dart';
import 'package:flutter/material.dart';

class ScrollBar extends StatefulWidget {
  const ScrollBar({Key? key}) : super(key: key);

  @override
  _ScrollBarState createState() => _ScrollBarState();
}

class _ScrollBarState extends State<ScrollBar> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // pageController.animateToPage(
    //   index,
    //   duration: Duration(milliseconds: 1000),
    //   curve: Curves.fastOutSlowIn,
    // );
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DBlack,
      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        //  controller: pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          HomePage(),
          AllCoins(),
          Portfolio(),
          MyProfile(),
          // MyExpense(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(canvasColor: MBlack),
        child: BottomNavigationBar(
          backgroundColor: DBlack,
          // fixedColor: DBlack,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 26,
                  // color: kWhite,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.currency_bitcoin_outlined,
                  size: 26,
                  // color: kWhite,
                ),
                label: 'Coins'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.savings_outlined,
                  size: 26,
                  // color: kWhite,
                ),
                label: 'Portfolio'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                  size: 26,
                  // color: kWhite,
                ),
                label: 'Profile'),
          ],

          currentIndex: _selectedIndex,
          selectedItemColor: LYellow,
          unselectedItemColor: kWhite,
          onTap: onTapped,
        ),
      ),
    );
  }
}
