import 'package:flutter/material.dart';

class ServerErrorController extends ChangeNotifier {
  bool _hasError = false;

  bool get hasError => _hasError;

  void triggerError() {
    _hasError = true;
    notifyListeners();
  }

  void resetError() {
    _hasError = false;
    notifyListeners();
  }
}
