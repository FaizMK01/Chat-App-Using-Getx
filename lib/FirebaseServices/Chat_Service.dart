import 'package:chat_app/Models/MessageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ChatService extends ChangeNotifier{


  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;


  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firestore.collection("Users").snapshots().map((snapshot) {
      print("Snapshot docs: ${snapshot.docs}");
      return snapshot.docs.map((doc) {
        final user = doc.data();
        print("User data: $user");
        return user;
      }).toList();
    });
  }

  // GET ALL USERS STREAM EXCEPT BLOCKED USERS
  Stream<List<Map<String, dynamic>>> getUsersStreamExcludingBlocked() {

    final currentUser = auth.currentUser;
    return firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        . snapshots()
        .asyncMap((snapshot) async{
        final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

       // get all users
       final usersSnapshot = await firestore.collection('Users').get();

// return as stream list, excluding current user and blocked users
    return usersSnapshot.docs
        .where((doc) =>
    doc.data()['email'] != currentUser.email &&
    !blockedUserIds.contains(doc.id))
        .map( (doc) => doc.data())
        .toList();
  });
}


  Future<void> sendMessage(String receiverID, message) async {

    final String currentUserID = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    
    MessageModel messageModel = MessageModel(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    //construct chat room ID for the two users
    List<String> ids = [currentUserID , receiverID];
    ids.sort();// sort the ids to ensure the chatroom is the same for any 2 people
    String chatRoomID = ids.join('_');
    
    await firestore.collection
      ("chat_rooms").
    doc(chatRoomID).
    collection("messages").
    add(messageModel.toMap());




  }

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {

    List<String> ids = [userID , otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return firestore.collection("chat_rooms").doc(chatRoomID).collection('messages').orderBy('timestamp',descending: false).snapshots();

  }

  //report User
  Future<void> reportUser(String messageId, String userId) async {
    final currentUser = auth.currentUser;
    final report = {

      'reportedBy':currentUser!.uid,
      'messageId':messageId,
      'messageOwnerId':userId,
      'timestamp':FieldValue.serverTimestamp()
      
    };
    
    await firestore.collection('Reports').add(report);
}

  // block User
  Future<void> blockUser(String userId) async{
  final currentUser = auth.currentUser;
  await firestore
      .collection('Users').
      doc(currentUser !. uid)
      .collection('BlockedUsers')
      .doc(userId)
      .set ({});
  notifyListeners();
}

  //unblock

  Future<void> unblockUser(String blockedUserId) async {
    final currentUser = auth.currentUser;

    await firestore.
    collection('Users')
        .doc(currentUser !.uid)
        .collection('BlockedUsers')
        .doc(blockedUserId)
        .delete();
  }

  Stream<List<Map<String, dynamic>>> getBlockedUsersStream(String userId) {
    return firestore
        .collection('Users')
        .doc(userId)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      // Get list of blocked user IDs
      final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

      // Fetch user documents for blocked IDs
      final userDocs = await Future.wait(
        blockedUserIds.map((id) => firestore.collection('Users').doc(id).get()),
      );

      // Map user documents to a list of maps
      return userDocs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }


}