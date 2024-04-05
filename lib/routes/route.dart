import 'package:flutter/material.dart';

import '../screens/guest/AuthScreen.dart';
import '../screens/guest/WaitScreen.dart';
import '../screens/guest/ResetPassword.dart';
import '../screens/guest/homeVisitor.dart';
import '../screens/log/dialogScreen.dart';
import '../screens/log/home.dart';


const kAuthScreen ="/";
const kPasswordScreen ="/PasswordScreen";
const kHomeScreen ="/home";
const kErrorScreen ="/ErrorScreen";
const kResetPassword ="/ResetPassword";
const kDialogScreen ="/dialogScreen";
const kHomeVisitorScreen ="/homeVisitor";

var router = <String, WidgetBuilder>{
  kAuthScreen: (context) => const AuthScreen(),
  kHomeScreen: (context) => const Home(),
  kErrorScreen: (context) => const ErrorScreen(),
  kResetPassword: (context) => const ResetPassword(),
  kDialogScreen: (context) {
    final arguments = ModalRoute.of(context)!.settings.arguments; // Récupérer les arguments passés
    return DialogScreen(groupName: arguments as String); // Passer le nom du groupe dynamiquement
  },
  kHomeVisitorScreen: (context) => const HomeVisitor(),
};