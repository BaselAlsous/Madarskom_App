import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madarskom/Database/Database_School.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Widget/Gridtile.dart';
import 'package:madarskom/Widget/Search.dart';
import 'package:toast/toast.dart';
//Screens
import '../../Database/database.dart';
import '../../Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';
import 'Insid_Schools/Profile_schools.dart';


class MySchool extends StatefulWidget {
  @override
  _MySchoolState createState() => _MySchoolState();
}
class _MySchoolState extends State<MySchool> {
  bool isSearching = false;
  bool isLoading = false;
  bool haveSchoolSearched = false;
  QuerySnapshot searchResultSnapshot;
  TextEditingController searchSchoolController = new TextEditingController();
  void showToast() {
    Toast.show(SetLocalization.of(context)
        .getTranslateValue("Please check the entered name"),context,duration: Toast.LENGTH_LONG);
  }

   search() async {

    await DatabaseMethods()
        .searchBySchoolNameToGetSchool(searchSchoolController.text)
        .then((snapshot) {
      searchResultSnapshot = snapshot;
      if(searchResultSnapshot.documents.length>=1){
        setState(() {
          isLoading = false;
          haveSchoolSearched = true;
          print("if $searchResultSnapshot $searchSchoolController");
        });
      }else{
        setState(() {
          haveSchoolSearched = false;
          print("else $isLoading $haveSchoolSearched");
          showToast();
        });
      }
    });
  }

  Widget schoolSearched(){
    return haveSchoolSearched ? GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0
        ),
        shrinkWrap: true,
        itemCount: searchResultSnapshot.documents.length,
        itemBuilder: (context, index){
          return BuildGrid(
            img:searchResultSnapshot.documents[index].data["photoUrl"],
            desc: searchResultSnapshot.documents[index].data["Description"],
            title: searchResultSnapshot.documents[index].data["Name"],
            tap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileSchools(searchResultSnapshot.documents[index]))),
          );
        }) : Container();
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
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
                          Icons.school,
                          color: ConstantColor.filling,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    SetLocalization.of(context).getTranslateValue("Schools"),
                    style: GoogleFonts.notoSerif(
                      color: ConstantColor.appBarTitle,
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  buildSearch(searchSchoolController, search , context , ),
                  Container(
                      height: heightScreen * 0.65,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: haveSchoolSearched==true?schoolSearched(): BuildContainer()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class BuildContainer extends StatefulWidget {
  @override
  _BuildContainerState createState() => _BuildContainerState();
}
class _BuildContainerState extends State<BuildContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: SchoolDataBase().fetchData(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return BuildGrid(
                      img:snapshot.data[index]["photoUrl"],
                      title: snapshot.data[index]["Name"],
                      desc: snapshot.data[index]["Description"],
                      tap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileSchools(
                            snapshot.data[index],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
