import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:athle_pour_tous/routes/route.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> items = [
    'Bertrand Rixhon',
    'Raphael Mazy',
    'Gauthier Mazy',// TODO : changer par la db
  ];

  String getInitials(String groupName) {
    List<String> words = groupName.split(' ');
    if (words.length >= 2) {
      return words[0][0] + words[1][0];
    } else if (words.isNotEmpty) {
      return words[0][0];
    } else {
      return '';
    }
  }

  Color generateRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256), // Rouge
      random.nextInt(256), // Vert
      random.nextInt(256), // Bleu
    );
  }

  void _showAddGroupDialog() {
    String newGroupName = ''; // Initialiser le nom du nouveau groupe

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un nouveau groupe'),
          content: TextField(
            onChanged: (value) {
              newGroupName = value; // Mettre à jour le nom du groupe lorsque l'utilisateur tape
            },
            decoration: InputDecoration(hintText: 'Nom du groupe'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le dialogue sans ajouter de groupe
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newGroupName.isNotEmpty) {
                  // Vérifier si le nom du groupe est non vide
                  setState(() {
                    // Ajouter le nouveau groupe à la liste
                    items.add(newGroupName);
                  });
                  Navigator.of(context).pop(); // Fermer le dialogue après l'ajout du groupe
                }
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
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
          onPressed: _showAddGroupDialog, // Afficher le dialogue pour ajouter un nouveau groupe
          backgroundColor: Colors.green, // Couleur de fond verte
          foregroundColor: Colors.black,
          child: const Icon(Icons.add), // Couleur de l'icône noire
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
