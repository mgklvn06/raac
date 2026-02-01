import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  bool loading = false;

  void setLoading(bool v) {
    loading = v;
    notifyListeners();
  }
}
