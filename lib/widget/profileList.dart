import 'package:coinbank/colors.dart';
import 'package:coinbank/utilities/snackBar.dart';
import 'package:flutter/material.dart';

class ProfileList extends StatefulWidget {
  final String name;
  final String subText;
  var icon;

  ProfileList({
    required this.name,
    required this.subText,
    required this.icon,
  });

  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        showSnackBar(context, "Coming Soon...");
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(200, 255, 254, 254)),
              height: 80,
              // color: Color.fromARGB(200, 255, 254, 254),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: widget.icon,
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          Text(
                            widget.subText,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold,
                            ),
                            // style: kCoinCodeTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: SizedBox(
                height: 0,
                child: Divider(
                  // height: ,
                  color: kWhite,
                  thickness: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
