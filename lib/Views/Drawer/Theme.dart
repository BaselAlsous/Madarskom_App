import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import '../../Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';
import 'package:madarskom/Services/ThemeApp/SharedPreferenceTheme/Shared_Preference_Theme.dart';
import 'package:provider/provider.dart';

class DrakTheme extends StatefulWidget {
  @override
  _DrakThemeState createState() => _DrakThemeState();
}

class _DrakThemeState extends State<DrakTheme> {
  @override
  Widget build(BuildContext context) {
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    var widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
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
        SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: ConstantColor.filling,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Icon(
                    Icons.brightness_4_rounded,
                    color: ConstantColor.filling,
                  ),
                ),
              ],
            ),
            Text(
              SetLocalization.of(context).getTranslateValue("theme"),
              style: GoogleFonts.notoSerif(
                color: ConstantColor.appBarTitle,
                fontSize: 25,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              height: heightScreen * 0.2,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              elevation: 10.0,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 25),
                    width: widthScreen * 0.7,
                    child: Text(
                      SetLocalization.of(context)
                          .getTranslateValue("day or night customize your interface"),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSerif(
                        color: Colors.black,
                        fontSize: 19,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Container(
                    height: heightScreen * 0.3,
                    width: widthScreen * 0.8,
                    child: Column(
                      children: [
                        buildRadioListTile(
                            SetLocalization.of(context)
                                .getTranslateValue("system theme"),
                            context,
                            Icons.brightness_4_rounded,
                            ThemeMode.system),
                        buildRadioListTile(
                            SetLocalization.of(context)
                                .getTranslateValue("light theme"),
                            context,
                            Icons.wb_sunny_rounded,
                            ThemeMode.light),
                        buildRadioListTile(
                            SetLocalization.of(
                                context)
                                .getTranslateValue(
                                "dark theme"), context,
                            Icons.brightness_3, ThemeMode.dark),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Madarscom',
              style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 24),
            ),
          ),
        )
      ]),
    ));
  }

  Widget buildRadioListTile(
      String txt, BuildContext ctx, IconData icon, ThemeMode themeVal) {
    return RadioListTile(
      secondary: Icon(
        icon,
        color: ConstantColor.simpleIcon,
      ),
      value: themeVal,
      groupValue: Provider.of<ThemeProviders>(ctx, listen: true).tm,
      onChanged: (newThemValue) {
        Provider.of<ThemeProviders>(ctx, listen: false)
            .themeModeChange(newThemValue);
      },
      title: Text(
        txt,
        style: GoogleFonts.notoSerif(
          color: Colors.black,
          fontSize: 19,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

