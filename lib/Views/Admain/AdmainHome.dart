import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madarskom/Views/Admain/screenFeatureMessage.dart';
import 'package:madarskom/Views/Admain/screenProblemMessage.dart';
import 'package:madarskom/Views/login_Screens/Helper_login/Shared_Preference_Login.dart';
import 'package:madarskom/Views/login_Screens/Helper_login/authenticate.dart';
import 'package:madarskom/Views/login_Screens/Serveces_Login/auth.dart';
import 'package:madarskom/Views/App_Page.dart';

import '../../Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';

class AdmainHome extends StatefulWidget {
  @override
  _AdmainHomeState createState() => _AdmainHomeState();
}

class _AdmainHomeState extends State<AdmainHome> {
  @override
  Widget build(BuildContext context) {
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    var widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: heightScreen,
        child: Stack(
          children: [
            Container(
              height: heightScreen * 0.3,
              width: widthScreen,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                color: ConstantColor.appBap,
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Icon(
                        Icons.person,
                        color: ConstantColor.filling,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Admain home",
                  style: GoogleFonts.notoSerif(
                    color: Colors.white,
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  SizedBox(
                    height: heightScreen * 0.2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: heightScreen * 0.04 , right: widthScreen*0.09 , left: widthScreen *0.09),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                      elevation: 10.0,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyAppPage()));
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 15, bottom: 25),
                              width: widthScreen * 0.7,
                              child: Text(
                                'login as a user ',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.notoSerif(
                                  color: Colors.indigo[900],
                                  fontSize: 19,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: heightScreen * 0.04 , right: widthScreen*0.09 , left: widthScreen *0.09),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                      elevation: 10.0,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProblemMessageScreen()));
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 15, bottom: 25),
                              width: widthScreen * 0.7,
                              child: Text(
                                'problem message',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.notoSerif(
                                  color: Colors.indigo[900],
                                  fontSize: 19,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: heightScreen * 0.04 , right: widthScreen*0.09 , left: widthScreen *0.09),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                      elevation: 10.0,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FeatureMessageScreen()));
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 15, bottom: 25),
                              width: widthScreen * 0.7,
                              child: Text(
                                'Feature Suggestion message',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.notoSerif(
                                  color: Colors.indigo[900],
                                  fontSize: 19,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                        padding: EdgeInsets.only(top: heightScreen * 0.04 , right: widthScreen*0.09 , left: widthScreen *0.09),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          elevation: 10.0,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  HelpersFunctions.saveUserLoggedInSharedPreference(
                                      false);
                                  AuthService().signOut();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Authenticate()));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 15, bottom: 25),
                                  width: widthScreen * 0.7,
                                  child: Text(
                                    'log out',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.notoSerif(
                                      color: Colors.indigo[900],
                                      fontSize: 19,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ]),
              ),
            ),

          ],
        ),
      ),
    ));
  }
}
