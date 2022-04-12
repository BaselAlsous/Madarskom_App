import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MenuItems extends StatefulWidget {
  
  IconData icon;
  Text title;
  Function ontap;
  Color iconcolor;
  MenuItems( {this.iconcolor,this.icon, this.title,this.ontap });

  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  
  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.width - MediaQuery.of(context).padding.top;
    final widthScreen = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.ontap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.05 , vertical: heightScreen * 0.03),
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 30,
              color: widget.iconcolor,
            ),
            SizedBox(
              width: 20,
            ),
              widget.title,
          ],
        ),
      ),
    );
  }
}