import 'package:flutter/material.dart';

extension ColorExtension on String {
  Color stringToColor() {
    switch (this) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      default:
        return Colors.white;
    }
  }
}
