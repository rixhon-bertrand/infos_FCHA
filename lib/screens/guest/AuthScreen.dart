import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:athle_pour_tous/routes/route.dart';

import '../../constantes/errors_firebase.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _kFormMail = GlobalKey<FormState>();

  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  String _email = "";
  String _password = "";
  bool _isHide = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pushNamed(context, kHomeVisitorScreen); // Retour à l'écran visiteur
            },
          ), // Titre de l'écran
        ),
        body: Center(
          child: SingleChildScrollView(
            // centre les elements et pousse le contenu quand on ecrit avec le clavier
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Container(
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _kFormMail,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Entrez votre mail :',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          autofocus: true,
                          onChanged: (value) => setState(() => _email = value),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.email,
                            ),
                            hintText: ' Exemple@hotmail.com',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          autofocus: true,
                          onChanged: (value) =>
                              setState(() => _password = value),
                          obscureText: _isHide,
                          validator: (value) => value!.length < 6
                              ? "Le mote de passe est de minimum 6 characters "
                              : null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.lock,
                            ),
                            suffixIcon: IconButton(
                              icon: _isHide
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isHide = !_isHide;
                                });
                              },
                            ),
                            hintText: 'Mot de passe',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, kResetPassword);
                          },
                          child: Text(
                            'Mot de passe oublié ?  Cliquez ici !',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                          onPressed: _password.length < 6 ||
                              !emailRegex.hasMatch(_email)
                              ? null
                              : () async {
                            if (_kFormMail.currentState!.validate() &&
                                EmailValidator.validate(_email)) {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: _email,
                                  password: _password,
                                )
                                    .then((value) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text('Login réussi !'),
                                    ),
                                  );
                                  Navigator.pushNamed(
                                      context, kHomeScreen);
                                });
                              } on FirebaseAuthException catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    errors[e.code]!,
                                    style: const TextStyle(
                                        color: Colors.white),
                                  ),
                                ));
                              }
                            }
                          },
                          child: Text(
                            'Login'.toUpperCase(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _password.length < 6 ||
                              !emailRegex.hasMatch(_email)
                              ? null
                              : () async {
                            if (_kFormMail.currentState!.validate())
                            {
                              // TO DO
                            }
                          },
                          child: const Text(
                            'Créer un compte',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
