import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madarskom/Database/database.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';
import 'package:madarskom/Views/chat_Screens/Chat.dart';
import 'package:madarskom/Views/login_Screens/Helper_login/Shared_Preference_Login.dart';
import 'package:toast/toast.dart';

class ProfileSchools extends StatefulWidget {
  final DocumentSnapshot items;

  ProfileSchools(this.items);

  @override
  _ProfileSchoolsState createState() => _ProfileSchoolsState();
}

class _ProfileSchoolsState extends State<ProfileSchools> {
  String myName;
  String id;
  var searchResultSnapshot;
  void showToast(){  Toast.show(SetLocalization.of(context)
      .getTranslateValue("you can't send message to yourself"),context,duration: Toast.LENGTH_LONG);}
  List userProfilesList = [];

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
  sendMessage(String userName) {
    List<String> users = [myName, userName];
    String chatRoomId = getChatRoomId(myName, userName);
    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };
    DatabaseMethods().addChatRoom(chatRoom, chatRoomId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(chatRoomId: chatRoomId,),
      ),
    );
  }
  getUserName() {
    HelpersFunctions.getResultIdInSharedPreference()
        .then((value) => setState(() => id = value));
    HelpersFunctions.getUserNameSharedPreference()
        .then((value) => setState(() => myName = value));
    print(id);
  }
  fetchDatabaseList() async {
    dynamic resultant = await DatabaseMethods().getUserList(widget.items["ID"]);

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
        // print(userProfilesList);
      });
    }
  }

  @override
  void initState() {
    getUserName();
    fetchDatabaseList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'assets/images/profil/profile.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            ListView(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(25),
                      alignment: Alignment.topLeft,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: ConstantColor.back,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              elevation: 7),
                          child: Icon(
                            Icons.arrow_back,
                            color: ConstantColor.filling,
                          ),
                          onPressed: () => Navigator.of(context).pop()),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 74.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Card(
                            color: ConstantColor.cardColor,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 85.0, bottom: 85.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Align(
                                            child: Text(widget.items["Name"],
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        50, 50, 93, 1),
                                                    fontSize: 28.0)),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 34.0,
                                                  right: 34.0,
                                                  top: 8),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: ConstantColor.button,
                                                  textStyle:
                                                      GoogleFonts.notoSerif(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  ),
                                                ),
                                                child: Text(
                                                  SetLocalization.of(context)
                                                      .getTranslateValue(
                                                          "Contact"),
                                                ),
                                                onPressed: () {
                                                  if (myName != userProfilesList[0]['Name']) {
                                                    sendMessage(userProfilesList[0]['Name']);
                                                  }else  showToast();
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 15.0),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Column(
                                                  children: [
                                                    Row(children: [
                                                      Icon(Icons.person,
                                                          color: ConstantColor
                                                              .simpleIcon,
                                                          size: 20.0),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                          widget.items[
                                                          "Supwevising"],
                                                          style: TextStyle(
                                                              color: ConstantColor
                                                                  .textProfileColor,
                                                              fontSize: 17.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w300)),
                                                    ]),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.email,
                                                            color: ConstantColor
                                                                .simpleIcon,
                                                            size: 20.0),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            widget.items["Email"],
                                                            style: TextStyle(
                                                                color: ConstantColor
                                                                    .textProfileColor,
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.people_alt_outlined,
                                                            color: ConstantColor
                                                                .simpleIcon,
                                                            size: 20.0),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            widget.items["Mexid"] ==
                                                                true
                                                                ? "Mexid"
                                                                : "notmexid",
                                                            style: TextStyle(
                                                                color: ConstantColor
                                                                    .textProfileColor,
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w300)),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .people,
                                                            color: ConstantColor
                                                                .simpleIcon,
                                                            size: 20.0),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            widget.items[
                                                            "Number Student"],
                                                            style: TextStyle(
                                                                color: ConstantColor
                                                                    .textProfileColor,
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w300)),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.class_,
                                                            color: ConstantColor
                                                                .simpleIcon,
                                                            size: 20.0),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            widget.items[
                                                            "Number Class"],
                                                            style: TextStyle(
                                                                color: ConstantColor
                                                                    .textProfileColor,
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w300)),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.trending_down,
                                                            color: ConstantColor
                                                                .simpleIcon,
                                                            size: 20.0),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            widget.items[
                                                            "Lowest Class"],
                                                            style: TextStyle(
                                                                color: ConstantColor
                                                                    .textProfileColor,
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w300)),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.trending_up,
                                                            color: ConstantColor
                                                                .simpleIcon,
                                                            size: 20.0),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            widget.items[
                                                                "Height Class"],
                                                            style: TextStyle(
                                                                color: ConstantColor
                                                                    .textProfileColor,
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Divider(
                                                      height: 20.0,
                                                      thickness: 1.5,
                                                      indent: 32.0,
                                                      endIndent: 32.0,
                                                    ),
                                                    Center(
                                                      child: Text('Location',style: TextStyle(
                                                        fontSize: 22,
                                                      ),),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                          children: [
                                                            Icon(Icons.location_on,
                                                                color: ConstantColor
                                                                    .simpleIcon,
                                                                size: 20.0),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                                widget.items["Address"],
                                                                style: TextStyle(
                                                                    color: ConstantColor
                                                                        .textProfileColor,
                                                                    fontSize: 18.0,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w300)),
                                                          ],
                                                        ),
                                                    SizedBox(
                                                          height: 10,
                                                        ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.location_city,
                                                            color: ConstantColor
                                                                .simpleIcon,
                                                            size: 20.0),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            widget.items[
                                                            "Province"],
                                                            style: TextStyle(
                                                                color: ConstantColor
                                                                    .textProfileColor,
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w300)),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                      Icon(Icons.phone,
                                                          color: ConstantColor
                                                              .simpleIcon,
                                                          size: 20.0),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(widget.items["Phone"],
                                                          style: TextStyle(
                                                              color: ConstantColor
                                                                  .textProfileColor,
                                                              fontSize: 17.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w300)),
                                                    ]),


                                                  ])),

                                          Divider(
                                            height:20,
                                            thickness: 1.5,
                                            indent: 32.0,
                                            endIndent: 32.0,
                                          ),

                                          Center(
                                            child: Text('Description',style: TextStyle(
                                              fontSize: 22,
                                            ),),
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 32.0, right: 32.0),
                                            child: Align(
                                              child: Text(
                                                  widget.items["Description"],
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.w300)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      FractionalTranslation(
                          translation: Offset(0.0, -0.5),
                          child: Align(
                            child: CachedNetworkImage(
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * .4,
                                      height:
                                          MediaQuery.of(context).size.height * .2,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                placeholder: (context, url) => Container(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 1.0,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Color(0xFFff6768))),
                                      width:
                                          MediaQuery.of(context).size.width * .4,
                                    ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error, size: 150),
                                width: MediaQuery.of(context).size.width * .4,
                                fit: BoxFit.cover,
                                imageUrl: widget.items['photoUrl'].toString()),
                            alignment: FractionalOffset(0.5, 0.0),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
