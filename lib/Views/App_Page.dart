import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';
import 'package:madarskom/Services/ConvertLanguage/Language.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Widget/Drawer.dart';
import 'package:madarskom/main.dart';

//Screens
import 'Admain/AdmainHome.dart';
import 'Category/Category.dart';
import 'HomePage/myHome.dart';
import 'chat_Screens/ChatRoom.dart';
import 'login_Screens/Helper_login/Shared_Preference_Login.dart';

class MyAppPage extends StatefulWidget {
  @override
  _MyAppPageState createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  int selectPageIndex = 1;
  String id;
  String adminEmail;
  QuerySnapshot searchResultJobSnapshot;
  QuerySnapshot searchResultSchoolSnapshot;

  getAdminEmail() {
    HelpersFunctions.getUserEmailSharedPreference()
        .then((value) => setState(() {
              adminEmail = value;
            }));
  }

  void selectPage(value) {
    setState(() {
      selectPageIndex = value;
    });
  }

  @override
  void initState() {
    getUserId();
    fllterJop();
    fllterSchool();
    getAdminEmail();
    super.initState();
  }

  getUserId() {
    HelpersFunctions.getResultIdInSharedPreference()
        .then((value) => setState(() => id = value));
  }

  Future fllterJop() async {
    await Firestore.instance
        .collection("AddJob")
        .where('ID', isEqualTo: id)
        .getDocuments()
        .then((value) => setState(() {
              searchResultJobSnapshot = value;
            }));
  }

  Future fllterSchool() async {
    await Firestore.instance
        .collection("AddSchool")
        .where('ID', isEqualTo: id)
        .getDocuments()
        .then((value) => setState(() {
              searchResultSchoolSnapshot = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> pages = [
      {
        'Page': UserEditInfoStream(fllterSchool(), fllterJop(),
            searchResultJobSnapshot, searchResultSchoolSnapshot),
        'Title': SetLocalization.of(context).getTranslateValue("profile")
      },
      {
        'Page': MyCategoryPage(),
        'Title': SetLocalization.of(context).getTranslateValue("Category")
      },
      {'Page': ChatRoom(),
        'Title':  SetLocalization.of(context).getTranslateValue('Chat Room')
      },
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ConstantColor.appBap,
          title: Text(
            pages[selectPageIndex]['Title'],
            style: GoogleFonts.notoSerif(
              color: Colors.white,
              fontSize: 25,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
          actions: [
            lang(),
            adminEmail == "admin@gmail.com"
                ? IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdmainHome()),
                      );
                    },
                  )
                : SizedBox()
          ],
        ),
        body: pages[selectPageIndex]['Page'],
        drawer: BuildDrawer(),
        bottomNavigationBar: buildNavigationBar(context));
  }

  buildNavigationBar(context) {
    return CurvedNavigationBar(
      index: selectPageIndex,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      buttonBackgroundColor: ConstantColor.filling,
      color: ConstantColor.navigationBar,
      height: 60,
      items: [
        Icon(Icons.person, color: ConstantColor.navigationBarIcons),
        Icon(Icons.category, color: ConstantColor.navigationBarIcons),
        Icon(Icons.chat, color: ConstantColor.navigationBarIcons),
      ],
      animationDuration: Duration(milliseconds: 600),
      animationCurve: Curves.fastOutSlowIn,
      onTap: selectPage,
    );
  }

  Container lang() {
    return Container(
      margin: EdgeInsets.all(10),
      child: DropdownButton(
        underline: SizedBox(),
        elevation: 2,
        dropdownColor: ConstantColor.dropDown,
        icon: Icon(Icons.language, color: ConstantColor.filling),
        items: Language.languageList()
            .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                  value: lang,
                  child: Row(
                    children: [Text(lang.flag), Text(lang.name)],
                  ),
                ))
            .toList(),
        onChanged: (lang) {
          _changeLanguage(lang);
        },
      ),
    );
  }

  void _changeLanguage(lang) {
    Locale _temp;
    switch (lang.languageCode) {
      case 'en':
        _temp = Locale(lang.languageCode, 'US');
        break;
      case 'ar':
        _temp = Locale(lang.languageCode, 'JO');
        break;
      default:
        _temp = Locale('en', 'US');
        break;
    }

    MyApp.setLocale(context, _temp);
  }
}
