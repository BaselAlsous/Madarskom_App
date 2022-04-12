import 'package:flutter/material.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Widget/Card_category.dart';
import 'package:madarskom/Widget/Carousel_pro.dart';

class MyCategoryPage extends StatefulWidget {
  @override
  _MyCategoryPageState createState() => _MyCategoryPageState();
}

class _MyCategoryPageState extends State<MyCategoryPage> {
  void selectRequest(value) {
    Navigator.of(context).pushNamed(value == 0
        ? '/school'
        : value == 1
            ? '/job'
            : '/owner');
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = (MediaQuery.of(context).size.height);
    final Map<String, Map<String, String>> homeCards = {
      "school": {
        "title": SetLocalization.of(context)
            .getTranslateValue("Show the privater schools in Jordan"),
        "image": 'assets/images/items/itemschool.ico'
      },
      "job": {
        "title": SetLocalization.of(context)
            .getTranslateValue("Find a new job ( Employment requests )"),
        "image": 'assets/images/items/itemjob.ico'
      },
      "owners": {
        "title": SetLocalization.of(context)
            .getTranslateValue("School owners , Share your own school here"),
        "image": 'assets/images/items/itemowner.ico'
      }
    };
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyCarouesl(),
              SizedBox(height: heightScreen * 0.028),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CardHorizontal(
                    cta: SetLocalization.of(context).getTranslateValue("View"),
                    title: homeCards["school"]['title'],
                    img: homeCards["school"]['image'],
                    tap: () => selectRequest(0)),
              ),
              SizedBox(height: heightScreen * 0.028),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CardHorizontal(
                    cta: SetLocalization.of(context).getTranslateValue("View"),
                    title: homeCards["job"]['title'],
                    img: homeCards["job"]['image'],
                    tap: () => selectRequest(1)),
              ),
              SizedBox(height: heightScreen * 0.028),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CardHorizontal(
                    cta: SetLocalization.of(context).getTranslateValue("View"),
                    title: homeCards["owners"]['title'],
                    img: homeCards["owners"]['image'],
                    tap: () => selectRequest(2)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
