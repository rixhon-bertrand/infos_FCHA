import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:athle_pour_tous/routes/route.dart';

import '../../constantes/methods.dart';
import '../../db/database.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blue,
                ),
                onTap: () {
                  Navigator.pushNamed(context, kDialogScreen, arguments: items[index]); //ouvrir la conversation
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddGroupDialog(context, (String newGroupName) {
              setState(() {
                items.add(newGroupName);
              });
            });
          },
          backgroundColor: Colors.green, // Couleur de fond verte
          foregroundColor: Colors.black,
          child: const Icon(Icons.add), // Couleur de l'icône noire
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
