
import 'package:flutter/material.dart';
import 'package:madarskom/Services/ConvertLanguage/SetLanguage.dart';
import 'package:madarskom/Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';


 Widget buildSearch (TextEditingController st , Function done ,BuildContext context,   )  {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Container(
      width: double.infinity,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.12),
              offset: Offset(0, 10),
              blurRadius: 30)
        ],
      ),
      child: Center(
        child: ListTile(
          title: TextField(
            style: TextStyle(color : ConstantColor.searchColor),
            controller: st,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText:
              SetLocalization.of(context).getTranslateValue("Search"),
              hintStyle: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.search),
            onPressed: done,
          ),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed:(){
              st.clear();
            },
          ),
        ),
      ),
    ),
  );
}
