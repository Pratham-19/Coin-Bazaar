// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:coinbank/colors.dart';
import 'package:coinbank/pages/login/signUp.dart';
import 'package:coinbank/scrollBar.dart';
import 'package:coinbank/utilities/snackBar.dart';
import 'package:coinbank/widget/google_facebook.dart';
import 'package:coinbank/widget/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isSelected = true;
  bool _isVisible = true;
  bool loading = false;
  bool isVisbile = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSelected = true;
    _isVisible = true;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailPasswordController.dispose();
  }

  sendEmailVerification(BuildContext context) async {
    try {
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Display error message
    }
  }

  signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
      }
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ScrollBar()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      showSnackBar(context, e.message!);
      showSnackBar(context, "Try Again Later..");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (Route<dynamic> route) => false); // Displaying the error message
    }
  }

  loginWithEmail({
    email,
    password,
    context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = FirebaseAuth.instance.currentUser!;
      if (!user.emailVerified) {
        await sendEmailVerification(context);
        // restrict access to certain things using provider
        // transition to another page instead of home screen
      }
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ScrollBar()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      showSnackBar(context, "Try Again..");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (Route<dynamic> route) => false);
    }
    // Displaying the error message
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return loading
        ? const Center(
            child: CircularProgressIndicator(
              color: kGreen,
            ),
          )
        : Scaffold(
            backgroundColor: DBlack,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Spacer(
                      flex: 10,
                    ),
                    Container(
                      height: height * 0.050,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: kDarkBlack,
                          borderRadius: BorderRadius.circular(12)),
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSelected = true;
                                  // print("Sign In: $isSelected");
                                });
                              },
                              child: Container(
                                width: constraints.maxWidth / 2,
                                decoration: isSelected
                                    ? BoxDecoration(
                                        color: kBlack,
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                    : null,
                                child: Center(
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                        color: isSelected ? kWhite : kGrey,
                                        fontFamily: "MYRIADPRO"),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSelected = false;
                                  print("Sign Up: $isSelected");
                                });
                              },
                              child: Container(
                                width: constraints.maxWidth / 2,
                                decoration: isSelected
                                    ? null
                                    : BoxDecoration(
                                        color: kBlack,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                child: Center(
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                        color: isSelected ? kGrey : kWhite,
                                        fontFamily: "MYRIADPRO"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                    ),
                    const Spacer(
                      flex: 12,
                    ),
                    // Sign UP Text
                    isSelected
                        ? const Text(
                            "Sign in",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 32,
                            ),
                          )
                        : const Text(
                            "Sign up",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 32,
                            ),
                          ),
                    const Spacer(
                      flex: 5,
                    ),
                    isSelected ? signInLayout(height, isVisbile) : SignUp(),
                    const Spacer(
                      flex: 1,
                    ),
                    Row(
                      children: [
                        FGButtom(
                          height: height * 0.06,
                          width: width / 2.5,
                          text: "Facebook",
                          image: "lib/assets/facebook.png",
                          onTap: () {
                            showSnackBar(context, "Coming Soon..");
                          },
                        ),
                        const Spacer(),
                        FGButtom(
                          height: height * 0.06,
                          width: width / 2.5,
                          text: "Google",
                          image: "lib/assets/google.png",
                          onTap: () async {
                            // setState(() {
                            //   loading = true;
                            // });
                            await signInWithGoogle(context);
                            // await FirebaseAuthMethods.signInWithGoogle(context);
                            // setState(() {
                            //   loading = false;
                            // });
                          },
                        )
                      ],
                    ),
                    const Spacer(
                      flex: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        // await context
                        //     .read<FirebaseAuthMethods>()
                        //     .signInAnonymously(context);

                        setState(() {
                          loading = false;
                        });
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => ScrollBar()),
                            (Route<dynamic> route) => false);
                      },
                      child: Column(
                        children: [
                          Image(
                            image: const AssetImage("lib/assets/anonymous.png"),
                            height: height * 0.060,
                          ),
                          const Text(
                            "Use anonymous instead?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kGrey,
                                fontFamily: "MYRIADPRO",
                                height: 2),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 15,
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Container signInLayout(double height, bool isVisible) {
    return Container(
      height: height / 2.2,
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: const [
                Text(
                  "Email",
                  style: TextStyle(
                    color: kLightGrey,
                  ),
                ),
                Spacer(),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            textField(
              controller: emailController,
              hint: "Enter your email",
            ),
            const Spacer(
              flex: 2,
            ),
            const Text(
              "Password",
              style: TextStyle(
                color: kLightGrey,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            textField(
              controller: emailPasswordController,
              hint: "Enter your password",
              obscureText: _isVisible,
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    if (_isVisible != true) {
                      _isVisible = true;
                    } else {
                      _isVisible = false;
                    }
                  });
                },
                child: _isVisible
                    ? const Icon(
                        Icons.visibility_off,
                        color: kGrey,
                      )
                    : const Icon(
                        Icons.visibility,
                        color: kGrey,
                      ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            const Text(
              "Forgot password?",
              style: TextStyle(
                color: LYellow,
                //fontFamily: "MYRIADPRO",
              ),
            ),
            const Spacer(
              flex: 3,
            ),
            Container(
              height: constraints.maxHeight * 0.13,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40)),
              child: ElevatedButton(
                  onPressed: () async {
                    // setState(() {
                    //   loading = true;
                    // });
                    await loginWithEmail(
                        context: context,
                        email: emailController.text,
                        password: emailPasswordController.text);
                    // setState(() {
                    //   loading = false;
                    // });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: LYellow,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      color: kBlack,
                      // fontFamily: "MYRIADPRO",
                      fontSize: 15,
                    ),
                  )),
            ),
            const Spacer(
              flex: 1,
            ),
            const Text(
              "Or login with",
              textAlign: TextAlign.center,
              style: TextStyle(color: kGrey, fontSize: 13),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        );
      }),
    );
  }
}
