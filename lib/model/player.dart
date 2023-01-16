import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  String userId;
  bool hasFinished;
  num percentage;
  num totalTime;

  Player.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc)
      : userId = doc.id,
        hasFinished = doc['hasFinished'],
        percentage = doc['percentage'],
        totalTime = doc['totalTime'];
}

Stream<List<Player>> dbGetRoomPlayers(String roomId) async* {
  final db = FirebaseFirestore.instance;
  await for (final qsnap in db.collection("/TotalRoomsOnline/$roomId/UsersInRoom").orderBy('totalTime').snapshots()) {
    List<Player> players = [];
    for (final doc in qsnap.docs) {
      players.add(Player.fromFirestore(doc));
    }
    yield players;
  }
}