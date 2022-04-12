import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';

class CardHorizontal extends StatelessWidget {
  CardHorizontal(
      {this.title = "Placeholder Title",
      this.cta = "",
      this.img = "https://via.placeholder.com/200",
      this.tap});

  final String cta;
  final String img;
  final Function tap;
  final String title;

  @override
  Widget build(BuildContext context) {
    var h = (MediaQuery.of(context).size.height);
    return Container(
      height: h * 0.15,
      child: GestureDetector(
        onTap: tap,
        child: Card(
          color: ConstantColor.cardColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        bottomLeft: Radius.circular(6.0)),
                    image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.robotoSlab(
                          color: Color.fromRGBO(46, 47, 71, 1.0),
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        cta,
                        style: GoogleFonts.playfairDisplay(
                          color: Color.fromRGBO(52, 66, 177, 1.0),
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
