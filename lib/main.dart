import 'package:athle_pour_tous/routes/route.dart';
import 'package:athle_pour_tous/screens/guest/WaitScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: MaterialApp(
                theme: ThemeData(
                    canvasColor: Colors.transparent,
                    primaryColor: Colors.indigo),
                initialRoute: FirebaseAuth.instance.currentUser == null
                    ? kAuthScreen
                    : kHomeScreen,
                routes: router,
              ),decoration: const BoxDecoration(
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

            );
          } else {
            return const ErrorScreen();
          }
        });
  }
}
