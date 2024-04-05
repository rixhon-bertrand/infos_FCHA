import 'package:flutter/material.dart';
import '../../style/Styles.dart';

class DialogScreen extends StatelessWidget {
  final String groupName;

  const DialogScreen({Key? key, required this.groupName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$groupName'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Liste des messages à afficher
                // Ici, vous pouvez afficher les messages précédents s'il y en a
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0), // Ajouter une marge horizontale et verticale
            decoration: Styles.whiteBoxDialog, // Appliquer le style de boîte blanche avec l'ombre portée
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.emoji_emotions), // Icône pour les emojis
                    onPressed: () {
                      // Action pour insérer un emoji dans le champ de texte
                    },
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Écrire un message...',
                        border: InputBorder.none, // Retirer la bordure
                      ),
                      // Gérer la saisie du message
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.image_search), // Icône pour ajouter une image
                    onPressed: () {
                      // Action pour ajouter une image
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt), // Icône pour ajouter une pièce jointe
                    onPressed: () {
                      // Action pour ajouter une pièce jointe
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // Gérer l'envoi du message
                    },
                  ),
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}
