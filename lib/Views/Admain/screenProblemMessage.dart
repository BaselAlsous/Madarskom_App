import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madarskom/Database/problemAndFeatureMessage.dart';
import 'package:madarskom/Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';
import 'package:flutter/material.dart';
import 'AdmainHome.dart';

class ProblemMessageScreen extends StatefulWidget {
  @override
  _ProblemMessageScreenState createState() => _ProblemMessageScreenState();
}

class _ProblemMessageScreenState extends State<ProblemMessageScreen> {
  QuerySnapshot searchResultSnapshot;

  @override
  Widget build(BuildContext context) {
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    var widthScreen = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: heightScreen * 0.3,
              width: widthScreen,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
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
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdmainHome()))),
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Icon(
                          Icons.report_problem,
                          color: ConstantColor.filling,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: heightScreen * 0.05),
                    child: Text(
                      "Problem Message",
                      style: GoogleFonts.notoSerif(
                        color: Colors.white,
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Container(
                    height: heightScreen * 1,
                    margin: EdgeInsets.symmetric(vertical: 21),
                    padding: EdgeInsets.symmetric(
                        vertical: heightScreen * 0.011, horizontal: 22),
                    child: BuildContainer(),
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
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);

    return Container(
      child: FutureBuilder(
        future: ProblemDatabase().fetchData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Loding...'),
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(top: heightScreen * 0.07),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return BuildCard1(
                    title: snapshot.data[index]["email"],
                    problem: snapshot.data[index]["problem message"],
                    tap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          snapshot.data[index]["email"],
                          style: GoogleFonts.notoSerif(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          snapshot.data[index]["problem message"],
                          style: TextStyle(color: Colors.black87, fontSize: 17),
                        ),
                        actions: [
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.indigo[900],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () => snapshot.data[index].reference
                                  .delete()
                                  .whenComplete(() => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AdmainHome()))),
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class BuildCard1 extends StatelessWidget {
  final String problem;
  final Function tap;
  final String title;

  BuildCard1({this.title, this.problem, this.tap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: InkWell(
        onTap: tap,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          shadowColor: Colors.blueAccent,
          child: ListTile(
            title: Center(
              child: Padding(
                padding: const EdgeInsets.only( top:5.0,),
                child: Text(title, style: GoogleFonts.notoSerif(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ),
            onTap: tap,
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                  indent: 32.0,
                  endIndent: 32.0,
                ),
                Text(problem, style: TextStyle(color: Colors.black87,fontSize: 17)),
              ],
            )
          ),
        ),
      ),
    );
  }
}
//