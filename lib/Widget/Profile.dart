import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildProfile extends StatelessWidget {
  final Function onTap;
  final String title;
  final String image;

  const BuildProfile({this.onTap, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.only(right: 5, left: 5),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Color.fromRGBO(244, 245, 247, 1),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.fill,
                    )),
                height: heightScreen * 0.25,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(Icons.cloud_upload), onPressed: onTap),
                      Text(
                        title,
                        style: GoogleFonts.notoSerif(
                          color: Colors.black,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
