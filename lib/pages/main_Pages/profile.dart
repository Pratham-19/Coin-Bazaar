import 'package:coinbank/colors.dart';
import 'package:coinbank/widget/paymentPage.dart';
import 'package:coinbank/widget/profileList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  // var amt;

  User get user => FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MBlack,
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              user.displayName.toString(),
              style: const TextStyle(fontFamily: "Nunito"),
            ),
            Text(
              '${user.email.toString().substring(0, 4)}****${user.email.toString().substring(user.email.toString().length - 5, user.email.toString().length)}',
              style: const TextStyle(fontFamily: "Nunito"),
            ),
            const SizedBox(
              height: 5,
            ),
          ]),
        ),
        backgroundColor: DBlack,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddMoney()));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: LYellow,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Available to invest",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    color: DBlack,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25),
                              ),
                              Text(
                                "₹ 0.0",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    color: DBlack,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileList(
                  icon: const Icon(Icons.settings, size: 26),
                  name: "Account Settings",
                  subText: "Manage your KYC,Bank Details etc"),
              ProfileList(
                  icon: const Icon(Icons.supervised_user_circle_outlined,
                      size: 26),
                  name: "Invite and Earn",
                  subText: "Invite your friends and earn Rewards"),
              ProfileList(
                  icon: const Icon(Icons.support_agent_outlined, size: 26),
                  name: "Help & Support",
                  subText: "Get help with your account"),
              ProfileList(
                  icon: const Icon(CupertinoIcons.lock_shield, size: 26),
                  name: "Security",
                  subText: "Manage passwords & security"),
              ProfileList(
                  icon: const Icon(Icons.bug_report_outlined, size: 26),
                  name: "App Feedback",
                  subText: "Help us improve your experience"),
              ProfileList(
                  icon: const Icon(CupertinoIcons.info, size: 26),
                  name: "About Coin Bazaar",
                  subText: "About,Terms of Use,Privacy Policy"),
            ],
          ),
        ));
  }
}
