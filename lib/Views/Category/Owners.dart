
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Widget/Profile.dart';

import '../../Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';

class OwnerSchool extends StatefulWidget {
  @override
  _OwnerSchoolState createState() => _OwnerSchoolState();
}
class _OwnerSchoolState extends State<OwnerSchool> {
  void selectPage(index) {
    Navigator.of(context).pushNamed(index == 0 ? '/info_school' : '/info_job');
  }
  @override
  Widget build(BuildContext context) {
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    var widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
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
                        Icons.person,
                        color: ConstantColor.filling,
                      ),
                    ),
                  ],
                ),
                Text(
                  SetLocalization.of(context).getTranslateValue("School Owner"),
                  style: GoogleFonts.notoSerif(
                    color: ConstantColor.appBarTitle,
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                BuildProfile(
                  title: SetLocalization.of(context).getTranslateValue("Add school"),
                  onTap: () => selectPage(0),
                  image: 'assets/images/Owner/Owner_school.jpg',
                ),
                BuildProfile(
                  title: SetLocalization.of(context).getTranslateValue("Add job"),
                  onTap: () => selectPage(1),
                  image: 'assets/images/Owner/Owner_job.jpg',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
