import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> fetchGroups() async {
  try {
    final QuerySnapshot<Map<String, dynamic>> groupsSnapshot =
        await FirebaseFirestore.instance.collection('Groupes').get();

    final List<String> groups = groupsSnapshot.docs
        .map((doc) => doc.id)
        .toList(); // Récupérer les noms des groupes

    return groups;
  } catch (error) {
    print('Erreur lors de la récupération des groupes: $error');
    return []; // Retourner une liste vide en cas d'erreur
  }
}

Future<void> addGroup(String newGroupName) async {
  try {
// Utiliser le nom du groupe comme ID pour le document
    await FirebaseFirestore.instance.collection('Groupes').doc(newGroupName).collection('Messages').add({
      'date': Timestamp.now(),
      'content': "",
      // Ajoutez d'autres champs si nécessaire
    });
  } catch (e) {
// Gérer les erreurs éventuelles
    print('Erreur lors de l\'ajout du groupe : $e');
    throw e; // Remonter l'erreur pour la gérer à l'endroit où la méthode est appelée
  }
}

Future<void> addMessage(String groupName, String messageContent) async {
  try {
    await FirebaseFirestore.instance.collection('Groupes').doc(groupName).collection('Messages').add({
      'content': messageContent,
      'date': Timestamp.now(),
    });
  } catch (e) {
    print('Erreur lors de l\'ajout du message : $e');
    throw e;
  }
}
