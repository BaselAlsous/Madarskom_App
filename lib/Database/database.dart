import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
 List chat=[];


 getUserInfo(String email){
    return Firestore.instance
        .collection("Users")
        .where("Email", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

 // ignore: missing_return
 Future<bool> addChatRoom (chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

 getChats(String chatRoomId) async {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

 Future<void> addMessage(String chatRoomId, chatMessageData) async {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

 getUserChats(String itIsMyName) async {
    return await Firestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

 searchBySchoolNameToGetJob(String searchField) {
   return Firestore.instance
       .collection("AddJob")
       .where('Name', isEqualTo: searchField)
       .getDocuments();
 }

 searchBySchoolNameToGetSchool(String searchField) {
   return Firestore.instance
       .collection("AddSchool")
       .where('Name', isEqualTo: searchField)
       .getDocuments();
 }

 getContactName(String id) {
    return Firestore.instance
        .collection("Users")
        .where('id', isEqualTo: id)
        .getDocuments();
  }

 Future getUserList(String id) async {
   List itemsList = [];
   try {
     await Firestore.instance
         .collection("Users")
         .where('id', isEqualTo: id).getDocuments().then((querySnapshot) {
       querySnapshot.documents.forEach((element) {
         itemsList.add(element.data);
       });
     });
     return itemsList;
   } catch (e) {
     print(e.toString());
     return null;
   }
 }

 Future getPassWord(String email) async {
   List itemsList = [];
   try {
     await Firestore.instance
         .collection("Users")
         .where('Email', isEqualTo: email).getDocuments().then((querySnapshot) {
       querySnapshot.documents.forEach((element) {
         itemsList.add(element.data);
       });
     });
     return itemsList;
   } catch (e) {
     print(e.toString());
     return null;
   }
 }

}
