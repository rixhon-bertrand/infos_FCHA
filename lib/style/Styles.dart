import 'package:flutter/material.dart';

class Styles {
  static const EdgeInsets paddingAll30 = EdgeInsets.symmetric(
    horizontal: 15.0,
    vertical: 15.0,
  );
  static BoxDecoration whiteBox = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(
              0, 3),
        ),
      ],
    );
  static BoxDecoration whiteBoxDialog = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(50.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(
            0, 3),
      ),
    ],
  );
}