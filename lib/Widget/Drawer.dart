import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Views/login_Screens/Helper_login/Shared_Preference_Login.dart';
import 'package:madarskom/Views/login_Screens/Helper_login/authenticate.dart';
import 'package:madarskom/Views/login_Screens/Serveces_Login/auth.dart';
import 'package:madarskom/Widget/Menu_Items_In_Drawer.dart';


class BuildDrawer extends StatefulWidget {
  @override
  _BuildDrawerState createState() => _BuildDrawerState();
}

class _BuildDrawerState extends State<BuildDrawer> {
  String userName;
  String userEmail;

  getUserName() {
    HelpersFunctions.getUserNameSharedPreference()
        .then((value) => setState(() => userName = value));
    HelpersFunctions.getUserEmailSharedPreference()
        .then((value) => setState(() => userEmail = value));
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen =
        MediaQuery.of(context).size.width - MediaQuery.of(context).padding.top;
    final widthScreen = MediaQuery.of(context).size.width;
    return Container(
      width: widthScreen * 0.7,
      padding: EdgeInsets.symmetric(horizontal: 5),
      color: Colors.indigo[900].withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: heightScreen * 0.2,
          ),
          Icon(Icons.account_circle,
          size: 80,
          color: Colors.grey,),

          SizedBox(
            height: heightScreen * 0.01,
          ),
          Text(userName != null ? userName : 'User Name',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: widthScreen * 0.06,
                  color: Colors.white)),
          SizedBox(
            height: heightScreen * 0.01,
          ),
          Text(userEmail != null ? userEmail : 'User Email',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: widthScreen * 0.043,
                  color: Colors.white)),
          Divider(
            height: heightScreen * 0.1,
            color: Colors.grey[800],
            thickness: 0.7,
          ),
          MenuItems(
            iconcolor: Colors.yellow,
            icon: Icons.wb_sunny,
            title: Text(SetLocalization.of(context).getTranslateValue("theme"),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: widthScreen * 0.045,
                    color: Colors.white)),
            ontap: () => Navigator.of(context).pushNamed('/dark'),
          ),
          MenuItems(
            iconcolor: Colors.redAccent,
            icon: Icons.report_problem,
            title: Text(
                SetLocalization.of(context)
                    .getTranslateValue("Report a problem"),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: widthScreen * 0.045,
                      color: Colors.white,
                    )),
            ontap: () => Navigator.of(context).pushNamed('/problem'),
          ),
          MenuItems(
            iconcolor:  Colors.lightBlueAccent,
            icon: Icons.assignment_sharp,
            title: Text(
                SetLocalization.of(context)
                    .getTranslateValue("Feature Suggestion"),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: widthScreen * 0.045,
                      color: Colors.white,
                    )),
            ontap: () => Navigator.of(context).pushNamed('/suggestion'),
          ),
          MenuItems(
            iconcolor: Colors.grey,
            icon: Icons.info_sharp,
            title:
                Text(SetLocalization.of(context).getTranslateValue("About us"),
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: widthScreen * 0.045,
                          color: Colors.white,
                        )),
            ontap: () => Navigator.of(context).pushNamed('/about'),
          ),
          Divider(
            height: heightScreen * 0.13,
            color: Colors.white.withOpacity(0.8),
            thickness: 0.5,
            indent: 65,
            endIndent: 65,
          ),
          MenuItems(
            iconcolor: Colors.white,
            icon: Icons.exit_to_app,
            title:
                Text(SetLocalization.of(context).getTranslateValue("Log out"),
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: widthScreen * 0.045,
                          color: Colors.white,
                        )),
            ontap: () {
              HelpersFunctions.saveUserLoggedInSharedPreference(false);
              AuthService().signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
          ),
        ],
      ),
    );
  }
}
