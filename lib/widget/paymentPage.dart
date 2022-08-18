import 'package:coinbank/colors.dart';
import 'package:coinbank/widget/qrpage.dart';
import 'package:flutter/material.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({Key? key}) : super(key: key);

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  final TextEditingController amtController = TextEditingController();
  bool emptyText = false;
  @override
  void dispose() {
    super.dispose();
    amtController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: DBlack,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      backgroundColor: DBlack,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            const Text(
              "Add money to wallet",
              style:
                  TextStyle(color: kWhite, fontFamily: "Nunito", fontSize: 30),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                child: TextField(
                  // tex
                  style: const TextStyle(
                    color: DBlack,
                  ),
                  controller: amtController,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: InputDecoration(
                    errorText: emptyText ? "Amount can\'t be empty !!" : null,
                    isDense: true,
                    hintText: "Enter amount (INR)",
                    hintStyle: const TextStyle(
                        color: kGrey, fontSize: 14, fontFamily: "Nunito"),
                    filled: true,
                    // suffixIcon: suffixIcon,
                    focusColor: LYellow,
                    fillColor: kWhite,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(14.0),
                      ),
                      borderSide: BorderSide(
                        color: DYellow,
                        width: 2,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: kLightGrey,
                        // width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        amtController.text = "100";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(13)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "+ ₹100",
                          style: TextStyle(
                            color: kBlack,
                            fontFamily: "Nunito",
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        amtController.text = "500";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(13)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "+ ₹500",
                          style: TextStyle(
                            color: kBlack,
                            fontFamily: "Nunito",
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        amtController.text = "1000";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(13)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "+ ₹1000",
                          style: TextStyle(
                            color: kBlack,
                            fontFamily: "Nunito",
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  amtController.text.isEmpty
                      ? emptyText = true
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowQR(
                              amt: amtController.text,
                            ),
                          ),
                        );
                },
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    primary: LYellow,
                    minimumSize: Size(double.infinity, 50)),
                child: const Text(
                  "Continue to Pay",
                  style: TextStyle(
                    color: kBlack,
                    fontFamily: "Nunito",
                    fontSize: 17,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
