import 'package:flutter/material.dart';

class UtilsWidgets {
  static void showSnack(BuildContext context, String message) {
    ScaffoldMessenger.maybeOf(context)
        ?.showSnackBar(SnackBar(content: Text(message)));
  }
}
