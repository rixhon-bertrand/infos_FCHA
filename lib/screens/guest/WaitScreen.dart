import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.green,
                Colors.indigo,
              ],
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(
                //   'assets/FCHA.png',
                //   width: 40,
                //   height: 40,
                // ),
                SizedBox(width: 10),
                // Text(
                //   "Erreur réseau",
                //   style: TextStyle(color: Colors.red),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



