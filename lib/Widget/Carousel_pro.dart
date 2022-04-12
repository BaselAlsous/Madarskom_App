import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class MyCarouesl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

     var h= ( MediaQuery.of(context).size.height ) ;

    return Container(
      child: SizedBox(
        height: h * 0.25,
        width: double.infinity,
        child: Carousel(
          boxFit:BoxFit.fill ,
          dotSpacing: 20,
          dotIncreasedColor: Colors.black,
          dotColor: Colors.white,
          overlayShadowColors: Colors.black,
          indicatorBgPadding: 15.0,
          images: [
            Image.asset('assets/images/carousel/school1.png',fit: BoxFit.fill),
            Image.asset('assets/images/carousel/school2.png',fit: BoxFit.fill),
            Image.asset('assets/images/carousel/school3.png',fit: BoxFit.fill),
            Image.asset('assets/images/carousel/school4.png',fit: BoxFit.fill),
            Image.asset('assets/images/carousel/school5.png',fit: BoxFit.fill,),
          ],
        ),
      ),
    );
  }
}
