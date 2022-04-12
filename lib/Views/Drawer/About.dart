import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';


class MyAbout extends StatefulWidget {


  @override
  _MyAboutState createState() => _MyAboutState();
}

class _MyAboutState extends State<MyAbout> {
  Widget build(BuildContext context) {

    var appbar = AppBar(
      backgroundColor:ConstantColor.appBap,
      title: Text(SetLocalization.of(context).getTranslateValue("About us"),
      style: GoogleFonts.notoSerif(
        color: ConstantColor.filling,
        fontSize: 25,
        fontStyle: FontStyle.italic,
      ),),
      centerTitle: true,
    );

    return SafeArea(
      child: Scaffold(
          appBar: appbar,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Align(
                alignment: Alignment(0, -0.5),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/Madarskom.ico',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    Text("Madarscom",
                      style:GoogleFonts.notoSerif(
                        color: Colors.blue[600],
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),) ,
                    SizedBox(
                        height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                            0.5),
                    Text(
                      SetLocalization.of(context).getTranslateValue("© all rights reserved"),
                        style:GoogleFonts.notoSerif(
                          color: Colors.blue[600],
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),) ,

                  ],
                ),
              ),
            ),
          )),
    );
  }
}
