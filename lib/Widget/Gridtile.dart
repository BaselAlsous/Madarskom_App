import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class BuildGrid extends StatelessWidget {
  final String id;
  final String desc;
  var img;
  final Function tap;
  final String title;

  BuildGrid({this.id, this.title, this.desc, this.img, this.tap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.blueAccent.shade100,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: InkWell(
        onTap: tap,
        child: GridTile(
          footer: Column(
            mainAxisAlignment:MainAxisAlignment.center ,
            children: [
              Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  child: Center(
                    child: Text(title,
                        style: GoogleFonts.notoSerif(
                            color: Colors.white,
                            fontSize: 17,
                            fontStyle: FontStyle.italic)),
                  ))
            ],
          ),
          child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      image:
                          DecorationImage(image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
              placeholder: (context, url) => Container(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFff6768),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * .4,
                  ),
              errorWidget: (context, url, error) => Icon(Icons.error, size: 150),
              width: MediaQuery.of(context).size.width * .4,
              fit: BoxFit.cover,
              imageUrl: img.toString()),
        ),
      ),
    );
  }
}
