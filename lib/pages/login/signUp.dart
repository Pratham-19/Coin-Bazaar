// ignore_for_file: file_names

// import 'package:coinbank/app-notifier/routes/appRoutes.dart';
import 'package:coinbank/colors.dart';
import 'package:coinbank/pages/login/signIn.dart';
import 'package:coinbank/scrollBar.dart';
// import 'package:coinbank/utilities/firebase_auth.dart';
import 'package:coinbank/utilities/snackBar.dart';
import 'package:coinbank/widget/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpNameController = TextEditingController();
  bool _passNotVisible = true;

  @override
  void initState() {
    super.initState();
    _passNotVisible = true;
  }

  @override
  void dispose() {
    super.dispose();
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    signUpNameController.dispose();
  }

  signUpUser(email, password, name, context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => value.user!.updateDisplayName(name));
//         .then(function(result) {
//   return result.user.updateProfile({
//     displayName: name;
//   })
// }).catch(function(error) {
//   console.log(error);
// });

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ScrollBar()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        showSnackBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'The account already exists for that email.');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SignInScreen()),
            (Route<dynamic> route) => false);
        showSnackBar(context, "Login from here");
      }
      showSnackBar(context, e.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 2.2,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Text(
                "Name",
                style: TextStyle(
                  color: kLightGrey,
                ),
              ),
              const Spacer(),
              textField(
                controller: signUpNameController,
                hint: "Enter your name",
              ),
              const Spacer(
                flex: 2,
              ),
              const Text(
                "Email",
                style: TextStyle(
                  color: kLightGrey,
                ),
              ),
              const Spacer(),
              textField(
                controller: signUpEmailController,
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
                controller: signUpPasswordController,
                hint: "Enter your password",
                obscureText: _passNotVisible,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      if (_passNotVisible != true) {
                        _passNotVisible = true;
                      } else {
                        _passNotVisible = false;
                      }
                    });
                  },
                  child: _passNotVisible
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
                flex: 3,
              ),
              Container(
                height: constraints.maxHeight * 0.13,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(40)),
                child: ElevatedButton(
                    onPressed: () async {
                      await signUpUser(
                          signUpEmailController.text,
                          signUpPasswordController.text,
                          signUpNameController.text,
                          context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: LYellow,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: kBlack,
                        // fontFamily: "MYRIADPRO",
                        fontSize: 15,
                      ),
                    )),
              ),
              const Spacer(
                flex: 2,
              ),
              const Text(
                "Or sign up with",
                textAlign: TextAlign.center,
                style: TextStyle(color: kGrey, fontSize: 13),
              ),
              const Spacer(
                flex: 1,
              )
            ],
          );
        },
      ),
    );
  }
}
