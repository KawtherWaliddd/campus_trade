import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void navigateReplacementTo(Widget widget) {
    Navigator.pushReplacement(
        this, MaterialPageRoute(builder: (context) => widget));
  }
}
