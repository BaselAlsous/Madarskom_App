import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madarskom/Database/database.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';
import 'package:madarskom/Views/login_Screens/Helper_login/Shared_Preference_Login.dart';

import 'Chat.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.documents[index].data['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, ""),
                    chatRoomId:
                        snapshot.data.documents[index].data["chatRoomId"],
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants.myName = await HelpersFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: chatRoomsList(),
      ),
    );
  }
}

class Constants {
  static String myName;
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: EdgeInsets.only(bottom: 5.0, top: 5.0, left: 5.0, right: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, ConstantColor.appBap],
          )),
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.blue[900], borderRadius: BorderRadius.circular(40)),
          child: Text(userName.substring(0, 1),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontFamily: 'OverpassRegular',
                  fontWeight: FontWeight.w800)),
        ),
        title: Center(
          child: Text(userName,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'OverpassRegular',
                  fontWeight: FontWeight.w400)),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chat(
                chatRoomId: chatRoomId,
              ),
            ),
          );
        },
        onLongPress: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  SetLocalization.of(context)
                      .getTranslateValue('Delete'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            content: Text(
              SetLocalization.of(context)
                  .getTranslateValue('Are you sure'),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text(
                  SetLocalization.of(context)
                      .getTranslateValue('Cancel'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Firestore.instance.collection('chatRoom').document(chatRoomId).collection('chats').getDocuments().then((snapshot) {
                    for (DocumentSnapshot ds in snapshot.documents){
                      ds.reference.delete();
                    }
                  });
                   Firestore.instance.collection('chatRoom').document(chatRoomId).delete();
                   print(chatRoomId);
                  Navigator.pop(context, 'OK');
                },
                child: Text(
                    SetLocalization.of(context)
                        .getTranslateValue('OK'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
