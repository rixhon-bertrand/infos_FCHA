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
  static const BoxDecoration messageBox = BoxDecoration(
    color: Colors.lightBlueAccent,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
      bottomRight: Radius.circular(20.0),
    ),
  );

  static const TextStyle messageTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
  );

  static BoxDecoration getTimeBoxDecoration(bool isCurrentUser) {
    return BoxDecoration(
      color: isCurrentUser ? Colors.green : Colors.grey.withOpacity(0.5),
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  static TextStyle getTimeTextStyle(bool isCurrentUser) {
    return TextStyle(
      color: isCurrentUser ? Colors.white : Colors.black,
      fontSize: 12.0,
    );
  }
}