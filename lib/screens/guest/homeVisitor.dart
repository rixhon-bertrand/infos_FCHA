import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:athle_pour_tous/routes/route.dart';

import '../../constantes/methods.dart';
import '../../db/database.dart';

class HomeVisitor extends StatefulWidget {
  const HomeVisitor({Key? key}) : super(key: key);

  @override
  _HomeVisitorState createState() => _HomeVisitorState();
}

class _HomeVisitorState extends State<HomeVisitor> {
  late List<String> items;

  @override
  void initState() {
    super.initState();
    items =[];
    _SetGroups();
  }

  void _SetGroups() async {
    final List<String> fetchedGroups = await fetchGroups();
    setState(() {
      items = fetchedGroups;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () async {
              FirebaseAuth.instance.signOut();
              await Navigator.pushNamed(context, kAuthScreen);
            },
            child: const Text(
              "Liste des groupes d'informations",
              style: TextStyle(color: Colors.black), // Changer la couleur du texte en noir
            ),
          ),
          titleSpacing: 0.0,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black, // Changer la couleur de l'icône en noir
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, kAuthScreen);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.admin_panel_settings, color: Colors.black), // Bouton admin pour se logger
              onPressed: () {
                Navigator.pushNamed(context, kAuthScreen);//TODO changer par la fenetre guest
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4, // Effet ombragé
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar( // Icône avec les initiales
                  backgroundColor: generateRandomColor(), // Couleur aléatoire et claire
                  child: Text(
                    getInitials(items[index]),
                    style: TextStyle(color: Colors.white), // Couleur du texte en blanc
                  ),
                ),
                title: Text(items[index]),
                trailing: IconButton(
                  icon: Icon(Icons.notifications), // Icône pour activer ou désactiver les notification
                  onPressed: () {
                    // TODO Gérer l'activation ou la désactivation des notifications
                  },
                ),
                onTap: () {
                  Navigator.pushNamed(context, kDialogScreen, arguments: items[index]); //ouvrir la conversation
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
