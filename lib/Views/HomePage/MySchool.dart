import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Views/HomePage/editMySchool.dart';
import 'package:madarskom/Widget/Gridtile.dart';
import 'package:flutter/material.dart';

import '../../Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';

// ignore: must_be_immutable
class MySchools extends StatefulWidget {
  final Future fllterJob;
  QuerySnapshot searchResultSchoolSnapshot;

  MySchools(this.fllterJob, this.searchResultSchoolSnapshot);

  @override
  _MySchoolsState createState() => _MySchoolsState();
}

class _MySchoolsState extends State<MySchools> {
  var st = TextEditingController();

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
            SingleChildScrollView(
              child: Column(
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
                          Icons.add_box,
                          color: ConstantColor.filling,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text( SetLocalization.of(context).getTranslateValue("My School"),
                      style: GoogleFonts.notoSerif(
                        color: ConstantColor.appBarTitle,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightScreen * 0.07,
                  ),
                  Container(
                    height: heightScreen * 0.65,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: FutureBuilder(
                        future: widget.fllterJob,
                        builder: (_, snapshot) {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.0,
                                      crossAxisSpacing: 20.0,
                                      mainAxisSpacing: 20.0),
                              itemCount: widget
                                  .searchResultSchoolSnapshot.documents.length,
                              itemBuilder: (_, index) {
                                return BuildGrid(
                                    img: widget.searchResultSchoolSnapshot
                                        .documents[index].data["photoUrl"],
                                    title: widget.searchResultSchoolSnapshot
                                        .documents[index].data["Name"],
                                    desc: widget.searchResultSchoolSnapshot
                                        .documents[index].data["Description"],
                                    tap: () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditMySchool(
                                              widget.searchResultSchoolSnapshot
                                                  .documents[index]),
                                        )));
                              });
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
