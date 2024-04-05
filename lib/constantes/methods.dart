import 'dart:math';
import 'package:flutter/material.dart';

import '../db/database.dart';

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

void showAddGroupDialog(BuildContext context, Function(String) onAdd) {
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
            onPressed: () async {
              if (newGroupName.isNotEmpty) {
                // Ajouter le nouveau groupe à la base de données Firestore
                try {
                  await addGroup(newGroupName);
                  onAdd(newGroupName); // Appeler la fonction de rappel pour mettre à jour l'interface utilisateur
                  Navigator.of(context).pop(); // Fermer le dialogue après l'ajout du groupe
                } catch (e) {
                  // Gérer les erreurs éventuelles
                  print('Erreur lors de l\'ajout du groupe : $e');
                }
              }
            },
            child: Text('Ajouter'),
          ),
        ],
      );
    },
  );
}
