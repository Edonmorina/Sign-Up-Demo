import 'package:flutter/material.dart';

class SignUpTextFieldStates with ChangeNotifier {
  bool _isFirstNameValid = false;
  bool _isLastNameValid = false;
  bool _isDateValid = false;
  bool _isFirstStreetAddressValid = false;
  bool _isCityValid = false;
  bool _isStateValid = false;
  bool _isZipValid = false;

  bool get isFirstNameValid => _isFirstNameValid;
  bool get isLastNameValid => _isLastNameValid;
  bool get isDateValid => _isDateValid;
  bool get isFirstStreetAddressValid => _isFirstStreetAddressValid;
  bool get isCityValid => _isCityValid;
  bool get isStateValid => _isStateValid;
  bool get isZipValid => _isZipValid;

  void resetAllFields() {
    _isFirstNameValid = false;
    _isLastNameValid = false;
    _isDateValid = false;
    _isFirstStreetAddressValid = false;
    _isCityValid = false;
    _isStateValid = false;
    _isZipValid = false;
    notifyListeners();
  }

  void setIsFirstNameValidTo(bool bool) {
    _isFirstNameValid = bool;
    notifyListeners();
  }

  void setIsLastNameValidTo(bool bool) {
    _isLastNameValid = bool;
    notifyListeners();
  }

  void setIsDateValidTo(bool bool) {
    _isDateValid = bool;
    notifyListeners();
  }

  void setIsFirstStreetAddressValidTo(bool bool) {
    _isFirstStreetAddressValid = bool;
    notifyListeners();
  }

  void setIsCityValid(bool bool) {
    _isCityValid = bool;
    notifyListeners();
  }

  void setIsStateValid(bool bool) {
    _isStateValid = bool;
    notifyListeners();
  }

  void setIsZipValid(bool bool) {
    _isZipValid = bool;
    notifyListeners();
  }
}
