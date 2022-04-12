
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madarskom/Database/Database_Job.dart';
import 'package:madarskom/Database/database.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';
import 'package:madarskom/Widget/Gridtile.dart';
import 'package:madarskom/Widget/Search.dart';
//Screens
import '../../Services/ConvertLanguage/SetLanguage.dart';
import 'Insid_Job/Profile_jobs.dart';
import 'package:toast/toast.dart';

class MyJob extends StatefulWidget {
  @override
  _MyJobState createState() => _MyJobState();
}
class _MyJobState extends State<MyJob> {
  bool haveJopSearched = false;
  QuerySnapshot searchResultSnapshot;
  TextEditingController searchJopController = new TextEditingController();
  void showToast() {
    Toast.show(SetLocalization.of(context)
        .getTranslateValue("Please check the entered name"),context,duration: Toast.LENGTH_LONG);
  }
  
  Future search() async {
      await DatabaseMethods()
          .searchBySchoolNameToGetJob(searchJopController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        print(" $searchResultSnapshot $searchJopController");
        if (searchResultSnapshot.documents.length>=1) {
          setState(() {
            haveJopSearched = true;
            print("if  $haveJopSearched");
          });
        }else{
          setState(() {
            haveJopSearched = false;
            print("else  $haveJopSearched");
            showToast();
          });
        }
      });
    }

  // ignore: non_constant_identifier_names
  Widget JobSearched(){
    return haveJopSearched ? GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0
        ),
        shrinkWrap: true,
        itemCount:  searchResultSnapshot.documents.length  ,
        itemBuilder: (context, index){
          return  BuildGrid(
            img:searchResultSnapshot.documents[index].data["photoUrl"],
            desc: searchResultSnapshot.documents[index].data["Description"],
            title: searchResultSnapshot.documents[index].data["Name"],
            tap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileJob(searchResultSnapshot.documents[index]))),
          );
        }) : BuildContainer();
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
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon:Icon( Icons.arrow_back,
                        color: ConstantColor.filling,),
                        onPressed:()=> Navigator.of(context).pop(),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Icon(
                          Icons.work_outlined,
                          color: ConstantColor.filling,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    SetLocalization.of(context).getTranslateValue("Jobs"),
                    style: GoogleFonts.notoSerif(
                      color: ConstantColor.appBarTitle,
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  buildSearch(searchJopController , search ,context  ,),
                  Container(
                    height: heightScreen * 0.65,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child:  haveJopSearched == true ? JobSearched(): BuildContainer(),
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


class BuildContainer extends StatefulWidget {
  @override
  _BuildContainerState createState() => _BuildContainerState();
}

class _BuildContainerState extends State<BuildContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: JobDataBase().fetchData(),
          builder: (_ , snapshot){
            if (snapshot.connectionState == ConnectionState.waiting ){
              return Center(child: Text('Loading...'),);
            }else {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (_,index){
                    return BuildGrid(
                      img:snapshot.data[index]["photoUrl"],
                      title: snapshot.data[index]["Name"],
                      desc: snapshot.data[index]["Description"],
                      tap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileJob(snapshot.data[index]))),
                    );
                  });
            }
          }),

    );
  }




}




