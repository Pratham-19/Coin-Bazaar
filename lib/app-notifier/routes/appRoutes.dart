import 'package:coinbank/pages/On_Start_Pages/boardingPage.dart';
import 'package:coinbank/pages/On_Start_Pages/splashScreen.dart';
import 'package:coinbank/pages/login/signIn.dart';
import 'package:coinbank/pages/login/signUp.dart';
import 'package:coinbank/scrollBar.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splashScreenRoute = "/splashScreen";
  static const String onBoardingScreenRoute = "/onBoardingScreen";
  static const String signInScreenRoute = "/signInScreen";
  static const String signUpRoute = "/signUp";
  // static const String mobileSignUpRoute = "/mobileSignUp";
  static const String successSignUpScreenRoute = "successSignUp";
  static const String homeScreenRoute = "/homeScreen";
  static const String menuScreenRoute = "/menuScreen";

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreenRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const ScrollBar(),
          );
        }
      case splashScreenRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const SplashScreen(),
          );
        }
      case onBoardingScreenRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const OnBoardingScreen(),
          );
        }
      case signInScreenRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const SignInScreen(),
          );
        }
      case signUpRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const SignUp(),
          );
        }
      // case successSignUpScreenRoute:
      //   {
      //     return MaterialPageRoute(
      //       builder: (_) => const SuccessSignUpScreen(),
      //     );
      //   }
      // case menuScreenRoute:
      //   {
      //     return MaterialPageRoute(
      //       builder: (_) => const MenuScreen(),
      //     );
      //   }
    }
    return null;
  }
}
