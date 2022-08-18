import 'package:flutter/material.dart';
import 'package:coinbank/colors.dart';

class AppNotifiers extends ChangeNotifier {
  bool _signInType = true;
  bool get signInType => _signInType;

  void changeSignInUpType() {
    _signInType = !_signInType;
    notifyListeners();
  }

  bool _isVisible = true;
  bool get isVisible => _isVisible;

  get switchObsIcon {
    return _isVisible
        ? const Icon(
            Icons.visibility_off,
            color: kGrey,
          )
        : const Icon(
            Icons.visibility,
            color: kGrey,
          );
  }

  void toggleObs() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}
