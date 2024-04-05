import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:athle_pour_tous/style/Styles.dart';
import '../../db/database.dart';

class DialogScreen extends StatelessWidget {
  final String groupName;
  final TextEditingController _messageController = TextEditingController();

  DialogScreen({Key? key, required this.groupName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$groupName'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Groupes')
                  .doc(groupName)
                  .collection('Messages')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  reverse: true,
                  children: snapshot.data!.docs.map((document) {
                    final message = document['content'];
                    final date = (document['date'] as Timestamp).toDate();

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: Styles.messageBox,
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  message,
                                  style: Styles.messageTextStyle,
                                ),
                                SizedBox(height: 4.0),
                                Container(
                                  decoration:
                                  Styles.getTimeBoxDecoration(false),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: Text(
                                    '${date.hour}:${date.minute}',
                                    style: Styles.getTimeTextStyle(false),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: Styles.whiteBoxDialog,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.emoji_emotions), // Icône pour les emojis
                      onPressed: () {
                        // TODO Action pour insérer un emoji dans le champ de texte
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
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
                        // TODO Action pour ajouter une image
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt), // Icône pour ajouter une pièce jointe
                      onPressed: () {
                        // TODO Action pour ajouter une pièce jointe
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        // Récupérer le contenu du message depuis le champ de texte
                        String messageContent = _messageController.text;
                        // Ajouter le message à la base de données
                        addMessage(groupName, messageContent);
                        // Effacer le champ de texte après l'envoi du message
                        _messageController.clear();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
