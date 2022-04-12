import 'package:madarskom/Views/App_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:madarskom/Views/login_Screens/Helper_login/Shared_Preference_Login.dart';
import 'package:madarskom/Views/login_Screens/Helper_login/authenticate.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class MainSplashScreen extends StatefulWidget {
  @override
  _MainSplashScreenState createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  bool userIsLoggedIn;
  bool admainIsLoggedIn;

  getUserLoggedInState() async {
    await HelpersFunctions.getUserLoggedInSharedPreference()
        .then((value) => setState(() {
              userIsLoggedIn = value;
            }));
  }

  getAdminLoggedInState() async {
    await HelpersFunctions.getAdmainIsLoggedIn().then((value) => setState(() {
          admainIsLoggedIn = value;
        }));
  }

  @override
  void initState() {
    getUserLoggedInState();
    getAdminLoggedInState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SplashScreen(
            title: Text(
              'Madarscom',
              style: GoogleFonts.playfairDisplay(
                color: Colors.white,
                fontSize: 22,
                fontStyle: FontStyle.italic,
              ),
            ),
            gradientBackground: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.indigo[400],
                  Colors.indigo[900],
                ]),
            image: Image.asset('assets/images/Madarskom.ico'),
            loadingText: Text(
              'To organize Private Schools inside jordan ...',
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                color: Colors.white,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            photoSize: 70,
            seconds: 2,
            useLoader: false,
            navigateAfterSeconds: userIsLoggedIn != null
                ? userIsLoggedIn
                    ? MyAppPage()
                    : Authenticate()
                : Authenticate(),
        ),
    );
  }
}
