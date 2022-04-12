import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//Providers and Share Preference
import 'Services/ThemeApp/SharedPreferenceTheme/Shared_Preference_Theme.dart';
import 'package:provider/provider.dart';
//Language
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Services/ConvertLanguage/SetLanguage.dart';
//Theme
import 'Services/ThemeApp/DarkTheme.dart';
import 'Services/ThemeApp/Light_Theme.dart';
import 'Views/Drawer/Theme.dart';
//Drawer item
import 'Views/Drawer/Problem.dart';
import 'Views/Drawer/Suggestion.dart';
import 'Views/Drawer/About.dart';
//Screens
import 'Views/Splash_Screen/SplashScreen.dart';
import 'Views/chat_Screens/ChatRoom.dart';
import 'Views/Category/Insid_owner/JobInfo.dart';
import 'Views/Category/Insid_owner/SchoolInfo.dart';
import 'Views/Category/Jops.dart';
import 'Views/Category/Owners.dart';
import 'Views/Category/Schools.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProviders>(create: (ctx) => ThemeProviders()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    Provider.of<ThemeProviders>(context, listen: false).getThemeMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tm = Provider
        .of<ThemeProviders>(context, listen: true)
        .tm;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme(),
      themeMode: tm,
      theme: lightTheme(),
      title: 'Madarskom',
      home: MainSplashScreen(),
      routes: {
        '/ChatRoom': (context) => ChatRoom(),
        '/school': (context) => MySchool(),
        '/job': (context) => MyJob(),
        '/owner': (context) => OwnerSchool(),
        '/problem': (context) => MyProblem(),
        '/suggestion': (context) => MySuggestion(),
        '/about': (context) => MyAbout(),
        '/info_school': (context) => InfoSchool(),
        '/info_job': (context) => JobInfo(),
        '/dark': (context) => DrakTheme(),
      },
      locale: _locale,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ar', 'JO'),
      ],
      localizationsDelegates: [
        SetLocalization.localizationsDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocal, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocal.languageCode &&
              locale.countryCode == deviceLocal.countryCode) {
            return deviceLocal;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}

